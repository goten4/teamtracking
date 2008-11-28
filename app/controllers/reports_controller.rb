class ReportsController < ApplicationController
  before_filter :authorization_required
  before_filter :find_teams
  before_filter :find_team
  before_filter :get_period_type
  before_filter :find_period_by_sprint
  before_filter :find_period_by_month
  before_filter :find_period_by_range

  def index
    if @team.blank?
      flash[:notice] = "Pas d'équipe, pas de rapport !"
      render :action => "noteam"
    elsif request.post?
      
    end
  end

protected
  def authorization_required
    unless logged_in? && current_user.has_reports_permissions?
      logger.warn { "L'utilisateur #{current_user.login} n'a pas la permission de consulter les rapports" }
      redirect_back_or_default(root_path)
    end
  end
  
  def find_teams
    if current_user.has_role?('administrator') || current_user.has_role?('reports_reader')
      @team_list = Team.all.sort_by { |team| team.name}
    else
      @team_list = current_user.teams.sort_by { |team| team.name}
    end
  end
  
  def find_team
    @team = params[:team].blank? ? @team_list.first : Team.find(params[:team][:id])
  end
  
  def get_period_type
    if @team.blank? || @team.sprints.empty?
      default_period_type = "month"
    else
      default_period_type = "sprint"
    end
    @period_type = (params[:period_type] || default_period_type).to_sym
  end
  
  def find_period_by_sprint
    unless @team.blank? || @period_type != :sprint
      @sprint = params[:sprint].blank? ? @team.sprints.last : Sprint.find(params[:sprint][:id])
      @start_date = @sprint.starts_on
      @end_date = @sprint.ends_on
    end
  end

  def find_period_by_month
    unless @team.blank? || @period_type != :month
      @date_month = params[:date].blank? ? Date.today.month : params[:date][:month]
      @date_year = params[:date].blank? ? Date.today.year : params[:date][:year]
      @start_date = "#{@date_year}-#{@date_month}-01".to_date
      @end_date = @start_date.at_end_of_month
    end    
  end

  def find_period_by_range
    unless @team.blank? || @period_type != :range
      @start_date = ( params[:start_date].blank? ? Date.today.at_beginning_of_month : params[:start_date].to_utc(:european).to_date )
      @end_date = ( params[:end_date].blank? ? Date.today.at_end_of_month : params[:end_date].to_utc(:european).to_date )
    end    
  end
end
