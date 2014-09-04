# Capistrano recipe for the production server
# origin: RM

set :user, "deploy-platforms"
set :deploy_to, '/opt/www/platforms.makandra.com'
set :rails_env, 'production'
set :branch, 'master'
server "vogler.makandra.de", :app, :web, :cron, :db, :primary => true
server "moeller.makandra.de", :app, :web
