class TeamsController < ApplicationController
  layout 'application'
  
  before_filter :check_administrator_role
  before_filter :find_user, :only => [:index, :update, :destroy]

  def index
    @all_teams = Team.find(:all)
  end

  def update
    @team = Team.find(params[:id])
    unless @user.has_team?(@team.name)
      @user.teams << @team
    end
    redirect_to user_teams_path(@user)
  end

  def destroy
    @team = Team.find(params[:id])
    if @user.has_team?(@team.name)
      @user.teams.delete(@team)
    end
    redirect_to user_teams_path(@user)
  end

  def list
    @teams = Team.find(:all)
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

  def modify
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      flash[:notice] = 'L\'équipe a bien été modifiée'
      redirect_to(@team)
    else
      render :action => "edit"
    end
  end

  def delete
    @team = Team.find(params[:id])
    @team.destroy
    redirect_to(teams_url)
  end

protected

  def find_user
    @user = User.find(params[:user_id])
  end

end
