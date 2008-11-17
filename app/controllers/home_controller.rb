class HomeController < ApplicationController

  def index
    redirect_to :controller => "effective_attendances", :action => "index"
  end
end
