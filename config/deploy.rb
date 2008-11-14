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

set :application, "blog"
set :deploy_to, "/home/lorgioj/www/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, true

#############################################################
#	Servers
#############################################################

set :user, "lorgioj"
set :domain, "lorgiojimenez.com"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Subversion
#############################################################

set :repository,  "http://www.example.com/svn/example"
set :svn_username, "jim"
set :svn_password, "password"
set :checkout, "export"

#############################################################
#	Passenger
#############################################################

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"