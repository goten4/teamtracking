set :application, "teamtracking"
set :repository,  "github.com:goten4/teamtracking.git"
set :domain, "teamtracking.dnsalias.com"

set :scm, :git
set :deploy_via, :remote_cache
set :git_enable_submodules, 1

ssh_options[:paranoid] = false

set :deploy_to, "/var/www/#{application}"
set :use_sudo, false

role :app, domain
role :web, domain
role :db,  domain, :primary => true

task :update_config, :roles => [:app] do
  run "cp -Rf #{shared_path}/config/* #{release_path}/config/"
end
after "deploy:update_code", :update_config

# Override start task
deploy.task :start do
  # nothing
end

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
after :deploy, "passenger:restart"
