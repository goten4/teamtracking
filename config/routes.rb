ActionController::Routing::Routes.draw do |map|

  map.resources :companies
  map.resources :teams do |team|
    team.resources :sprints
  end

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'

  map.resources :users do |user|
    user.resources :roles
    user.resources :teams
  end

  map.resource :session

  map.root :controller => 'home',  :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
