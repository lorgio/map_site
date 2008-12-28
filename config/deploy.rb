# set :application, "set your application name here"
# set :repository,  "set your repository location here"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

# role :app, "your app-server here"
# role :web, "your web-server here"
# role :db,  "your db-server here", :primary => true

############################################################
#	Application
#############################################################

set :application, "map_site"
# set :deploy_to, "/home/lorgioj/www/#{application}"
set :deploy_to, "/home/lorgioj/#{application}"

#############################################################
#	Settings
#############################################################

# default_run_options[:pty] = true
set :use_sudo, false

ssh_options[:compression] = false
#############################################################
#	Servers
#############################################################

set :user, "lorgioj"
set :domain, "lorgiojimenez.com"
role :app, "lorgiojimenez.com"
role :web, "lorgiojimenez.com"
role :db,  "lorgiojimenez.com", :primary => true
# server domain, :app, :web
# role :db, domain, :primary => true

#############################################################
#	Git
#############################################################
set :scm, "git"
set :repository,  "git@github.com:lorgio/map_site.git"
set :branch, "master"
set :deploy_via, :remote_cache
default_run_options[:pty] = true

# set :scm_passphrase, "asdflkj1234" #This is your custom users password
# set :user, "deployer"

#############################################################
#	Passenger
#############################################################

# namespace :deploy do
#   desc "Restarting mod_rails with restart.txt"
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "touch #{current_path}/tmp/restart.txt"
#   end

deploy.task :start do
  # nothing happens so that the script/spin nohup crap doesn't fail
end
namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"