class TeamsController < ApplicationController
  
  before_filter :check_administrator_role
  before_filter :find_user, :only => [:index, :update, :destroy]

  def index
    @teams = Team.find(:all, :order => :name)
    render :action => "list" unless @user
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      flash[:notice] = 'L\'équipe a bien été créée'
      redirect_to(teams_url)
    else
      render :action => "new"
    end
  end

  def update
    @team = Team.find(params[:id])

    if @user
      unless @user.has_team?(@team.name)
        @user.teams << @team
      end
      redirect_to :back
    else
      if @team.update_attributes(params[:team])
        flash[:notice] = 'L\'équipe a bien été modifiée'
        redirect_to(@team)
      else
        render :action => "edit"
      end
    end
  end

  def destroy
    @team = Team.find(params[:id])

    if @user
      if @user.has_team?(@team.name)
        @user.teams.delete(@team)
      end
    else
      @team = Team.find(params[:id])
      @team.destroy
    end
    redirect_to :back
  end

protected

  def find_user
    @user = User.find(params[:user_id]) if params[:user_id]
  end

end
