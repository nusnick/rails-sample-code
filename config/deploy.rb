set :stages, %w(staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'
# Execute "bundle install" after deploy, but only when really needed
require "bundler/capistrano"


set(:app_env)     { rails_env }

role(:web) { domain }
role(:app) { domain }
role(:db, primary: true) { domain }

set(:deploy_to)    { "/var/www/#{application}" }
set(:current_path) { File.join(deploy_to, current_dir) }

set :scm, :git

set :deploy_via, :remote_cache
set :keep_releases, 3

set :rvm_type, :system
set :rvm_ruby_string, '2.0.0@sample'

# RVM integration
require "rvm/capistrano"

default_run_options[:pty] = true

after "deploy:restart", "deploy:cleanup"
after "deploy:update_code", "deploy:migrate"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
load 'deploy/assets'
# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end

desc "tail production log files"
task :tail_logs, :roles => :app do
  trap("INT") { puts 'Interupted'; exit 0; }
  run "tail -f #{shared_path}/log/#{type}.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end