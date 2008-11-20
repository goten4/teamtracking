class StatisticsController < ApplicationController
  before_filter :authorization_required
  before_filter :find_teams
  before_filter :find_team
  before_filter :get_type

  def index
  end

protected
  def authorization_required
    unless logged_in? && current_user.has_stats_permissions?
      logger.warn { "L'utilisateur #{current_user.login} n'a pas la permission de consulter les statistiques" }
      redirect_back_or_default(root_path)
    end
  end
  
  def find_teams
    if current_user.has_role?('administrator') || current_user.has_role?('stats_reader')
      @team_list = Team.all.sort_by { |team| team.name}
    else
      @team_list = current_user.teams.sort_by { |team| team.name}
    end
  end
  
  def find_team
    @team = params[:team].blank? ? @team_list.first : Team.find(params[:team][:id])
  end
  
  def get_type
    @type = params[:type] || :sprint;
  end
end
