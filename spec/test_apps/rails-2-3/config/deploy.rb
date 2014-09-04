# Capistrano recipe for deployment.
# origin: GM

set :stages, %w[ production ]
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :use_sudo, false
set :deploy_via, :export
set :repository, "git@dev.makandra.de:platforms2"
set :scm, :git

ssh_options[:forward_agent] = true

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    run "mkdir -p #{shared_path}/config" 
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml" 
  end

  desc "Make symlink for database yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml" 
  end

  desc "Warn about pending migrations"
  task :warn_if_pending_migrations, :roles => :db, :only => { :primary => true } do
    rails_env = fetch(:rails_env, 'production')
    run "cd #{release_path}; rake db:warn_if_pending_migrations RAILS_ENV=#{rails_env}"
  end

  desc "Do a dump of the DB on the remote machine using dumple"
  task :dump, :roles => :db do
    rails_env = fetch(:rails_env, 'production')
    run "cd #{current_path}; dumple --fail-gently #{rails_env}"
  end

  desc "Show usage of ~/dumps/ on remote host"
  task :show_dump_usage do
    run "dumple -i"
  end
  
end

namespace :deploy do

  desc "Create storage dir in shared path"
  task :setup_storage do
    run "mkdir -p #{shared_path}/storage"
  end
  
  task :symlink_storage do
    run "ln -nfs #{shared_path}/storage #{release_path}/storage"
  end

  task :restart do
    passenger.restart
  end

  task :start do
  end

  task :stop do
  end
  

end

namespace :craken do

  desc "Install raketab"
  task :install do
    rails_env = fetch(:rails_env, 'production')
    run "cd #{release_path} && rake craken:install RAILS_ENV=#{rails_env}"
  end

  desc "Uninstall raketab"
  task :uninstall do
    run "cd #{release_path} && rake craken:uninstall"
  end

end


before "deploy:update_code", "db:dump"
before "deploy:setup", :db
after "deploy:update_code", "db:symlink" 
after "deploy:update_code", "deploy:symlink_storage"
before "deploy:setup", 'deploy:setup_storage'
after "deploy:symlink", "db:warn_if_pending_migrations"
after "deploy:symlink", "craken:install"
after "deploy:restart", "db:show_dump_usage"
