require "rvm/capistrano"
require "bundler/capistrano"

set :application, "mars"
set :user, "deployer"             # adduser on domain server before running this
set :domain, "loft.is-a-geek.com"

# set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")   # should pick up the gemset if used
set :rvm_ruby_string, 'ruby-1.9.3-p320@mars'
set :rvm_type, :user

# file paths
set :repository,  "git@github.com:bannio/#{application}.git"
set :branch, "master"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true       # This is where Rails migrations will run
# role :db,  "your slave db-server here"

set :scm, 'git'
set :branch, 'master'
set :scm_verbose, true
set :use_sudo, false
set :rails_env, "production"
set :rake, 'bundle exec rake'

default_run_options[:pty] = true          # allow the entry of a password at the console
ssh_options[:forward_agent] = true        # to allow Capistrano to use the local keys (e.g. bigapple) for accessing github

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

namespace :deploy do

  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
  # desc "reload the database with seed data"
  # task :seed do
  #   run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  # end
  
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/application.example.yml"), "#{shared_path}/config/application.yml"
    puts "Now edit the config files in #{shared_path}"
  end
  after "deploy:setup", "deploy:setup_config"
  
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"    
  end
  after "deploy:finalize_update", "deploy:symlink_config"
  
  desc "Make sure local git is in sync with remote."
    task :check_revision, roles: :web do
      unless `git rev-parse HEAD` == `git rev-parse master`
        puts "WARNING: HEAD is not the same as master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
    before "deploy", "deploy:check_revision"
end

  desc "install the necessary prerequisites"
    task :bundle_install, :roles => :app do
      run "cd #{release_path} && bundle install"
    end 
    after "deploy:update_code", :bundle_install
