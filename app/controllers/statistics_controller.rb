class StatisticsController < ApplicationController
  before_filter :authorization_required
  before_filter :find_teams

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
      @team_list = Team.all
    else
      @team_list = current_user.teams
    end
  end
end
