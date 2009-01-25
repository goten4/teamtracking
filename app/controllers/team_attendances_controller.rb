class TeamAttendancesController < ApplicationController
  before_filter :find_team_list
  before_filter :find_team_or_current_user_team

  def index
  end

protected

  def find_team_list
    if current_user.has_role?('administrator')
      @team_list = Team.all :order => :name
    elsif current_user.has_role?('team_leader')
      @team_list = current_user.teams
    end
  end

  def find_team_or_current_user_team
    if current_user.has_role?('administrator')
      @team = Team.find(params[:team][:id]) if params[:team]
      @team ||= Team.first
    elsif current_user.has_role?('team_leader')
      @team = current_user.teams.find { |t| t.id == params[:team][:id] } if params[:team]
      @team ||= current_user.teams.first
    end
    if @team.blank?
      logger.warn { "Impossible de voir les infos de l'équipe" }
      redirect_back_or_default(root_path)
    end
  end

end
