class SprintsController < ApplicationController
  layout 'application'
  
  before_filter :check_administrator_role
  before_filter :find_team
  
  def index
    @sprints = @team.sprints.sort_by { |sprint| sprint.name }
  end

  def show
    @sprint = Sprint.find(params[:id])
  end

  def new
    @sprint = Sprint.new(:team_id => @team.id)
  end

  def edit
    @sprint = Sprint.find(params[:id])
  end

  def create
    @sprint = Sprint.new(params[:sprint])
    if @sprint.save
      flash[:notice] = 'Le sprint a bien été créé'
      redirect_to team_sprint_path(@team, @sprint)
    else
      render :action => "new"
    end
  end

  def update
    @sprint = Sprint.find(params[:id])
    if @sprint.update_attributes(params[:sprint])
      flash[:notice] = 'Le sprint a bien été modifié'
      redirect_to team_sprint_path(@team, @sprint)
    else
      render :action => "edit"
    end
  end

  def destroy
    @sprint = Sprint.find(params[:id])
    @sprint.destroy
    redirect_to(team_sprints_url(@team))
  end

protected
  def find_team
    @team = Team.find(params[:team_id])
  end
end
