class HomeController < ApplicationController

  before_filter :login_required

  def index
    if params[:date]
      @date = params[:date].to_date
    else
      @date = Date.today
    end
  end

  def update
    flash[:notice] = 'Votre saisie a bien été enregistrée'
    @date = Date.today
    render :action => :index
  end
end
