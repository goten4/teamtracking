class AttendancesController < ApplicationController
  before_filter :login_required
  before_filter :get_date
  before_filter :find_user_list
  before_filter :find_user_or_current_user
  before_filter :find_attendance_calendar
  
protected

  def update
    update_attendances
    flash[:notice] = 'Votre saisie a bien été enregistrée'
    render :action => "index"
  end

  def get_date
    @date = params[:date] ? params[:date].to_date : Date.today
  end
  
  def find_user_list
    if current_user.has_role?('administrator')
      @user_list = User.all :joins => :assignments, :conditions => ["team_id IN (?)", Team.all], :order => :name
    elsif current_user.has_role?('team_leader')
      @user_list = User.find_all_by_teams_and_company current_user.teams, current_user.job.company, :order => :name
    end
  end
  
  def current_user_or_first_of_list
    current_user.has_at_least_one_team? ? current_user : @user_list.first
  end

  def find_user_or_current_user
    if current_user.has_role?('administrator')
      @user = User.first(:joins => :assignments, :conditions => ["users.id = ? and team_id IN (?)", params[:user][:id], Team.all]) if params[:user]
      @user ||= current_user_or_first_of_list
    elsif current_user.has_role?('team_leader')
      @user = User.find_by_id_and_teams_and_company(params[:user][:id], current_user.teams, current_user.job.company, :order => :name) if params[:user]
      @user ||= current_user_or_first_of_list
    elsif current_user.has_at_least_one_team?
      @user = current_user
    end
    if @user.blank?
      logger.warn { "Impossible de saisir la présence : Pas d'équipe affectée" }
      redirect_back_or_default(root_path)
    end
  end
  
  def find_attendance_calendar
  end
  
  def update_attendances
    @attendance_calendar.flatten.each do |attendance|
      params[:attendance_ams].include?(attendance.day.to_s) ? attendance.am = 0.5 : attendance.am = 0
      params[:attendance_pms].include?(attendance.day.to_s) ? attendance.pm = 0.5 : attendance.pm = 0
      attendance.save!
    end
  end
end
