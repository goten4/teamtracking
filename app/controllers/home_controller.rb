class HomeController < ApplicationController
  before_filter :login_required

  def index
    if current_user.has_role?('administrator')
      render :action => "index"
    elsif current_user.has_role?('reports_reader')
      redirect_to :controller => "reports", :action => "index"
    elsif current_user.has_at_least_one_team?
      redirect_to :controller => "effective_attendances", :action => "index"
    else
      logger.warn { "L'utilisateur #{current_user.login} n'est affecté à aucune équipe" }
      redirect_to logout_path
    end
  end
end
