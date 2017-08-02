# config valid only for current version of Capistrano
lock "3.8.1"

set :application, "mars"
set :repo_url, "git@github.com:bannio/#{fetch(:application)}.git"
set :branch, "master"
set :user, "deployer"
set :migration_role, :app

# suggestions from capistrano-rails
# ---------------------------------
# If the environment differs from the stage name
# set :rails_env, 'staging'

# Defaults to :db role
# set :migration_role, :db

# Defaults to the primary :db server
# set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true

# Defaults to [:web]
set :assets_roles, [:web, :app]

# Defaults to 'assets'
# This should match config.assets.prefix in your rails config/application.rb
# set :assets_prefix, 'prepackaged-assets'

# RAILS_GROUPS env value for the assets:precompile task. Default to nil.
# set :rails_assets_groups, :assets

# If you need to touch public/images, public/javascripts, and public/stylesheets on each deploy
# set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you'd like to clean up old assets after each deploy,
# set this to the number of versions to keep
# set :keep_assets, 2

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/application.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# ---------------------------------
# end of Capistrano-rails suggestions
# ---------------------------------

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true



# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# ------------------------------------
# From http://www.talkingquickly.co.uk/2014/01/deploying-rails-apps-to-a-vps-with-capistrano-v3/
# ------------------------------------
# which config files should be copied by deploy:setup_config
# see documentation in lib/capistrano/tasks/setup_config.cap
# for details of operations
set(:config_files, %w(
  nginx.conf
  database.example.yml
  unicorn.rb
  unicorn_init.sh
))

# which config files should be made executable after copying
# by deploy:setup_config
set(:executable_config_files, %w(
  unicorn_init.sh
))

# files which need to be symlinked to other parts of the
# filesystem. For example nginx virtualhosts, log rotation
# init scripts etc.
set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:application)}"
  },
  {
    source: "unicorn_init.sh",
    link: "/etc/init.d/unicorn_#{fetch(:application)}"
  }
])

# namespace :deploy do
#   # make sure we're deploying what we think we're deploying
#   before :deploy, "deploy:check_revision"
#   # only allow a deploy with passing tests to deployed
#   before :deploy, "deploy:run_tests"
#   # compile assets locally then rsync
#   after 'deploy:symlink:shared', 'deploy:compile_assets_locally'
#   after :finishing, 'deploy:cleanup'

#   # remove the default nginx configuration as it will tend
#   # to conflict with our configs.
#   # before 'deploy:setup_config', 'nginx:remove_default_vhost'

#   # reload nginx to it will pick up any modified vhosts from
#   # setup_config
#   # after 'deploy:setup_config', 'nginx:reload'

#   # As of Capistrano 3.1, the `deploy:restart` task is not called
#   # automatically.
#   after 'deploy:publishing', 'deploy:restart'
# end

# ------------------------------------
# From previous version (edited)
# ------------------------------------
# namespace :deploy do

# desc "start unicorn server"
# task :start_unicorn do
#   on roles(:app) do
#     run "/etc/init.d/unicorn_#{fetch(:application)} start"
#   end
# end

# desc "stop unicorn server"
# task :stop_unicorn do
#   on roles(:app) do
#     run "/etc/init.d/unicorn_#{fetch(:application)} stop"
#   end
# end

# desc "restart unicorn server"
# task :restart_unicorn do
#   on roles(:app) do
#     run "/etc/init.d/unicorn_#{fetch(:application)} restart"
#   end
# end

# end

  # desc "reload the database with seed data"
  # task :seed do
  #   run "cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}"
  # end

#   task :setup_config, roles: :app do
#     sudo "ln -nfs #{fetch(:current_path)}/config/nginx.conf /etc/nginx/sites-enabled/#{fetch(:application)}"
#     sudo "ln -nfs #{fetch(:current_path)}/config/unicorn_init.sh /etc/init.d/unicorn_#{fetch(:application)}"
#     run "mkdir -p #{fetch(:shared_path)}/config"
#     put File.read("config/database.example.yml"), "#{fetch(:shared_path)}/config/database.yml"
#     put File.read("config/application.example.yml"), "#{fetch(:shared_path)}/config/application.yml"
#     puts "Now edit the config files in #{shared_path}"
#   end
#   after "deploy:setup", "deploy:setup_config"

#   task :symlink_config, roles: :app do
#     run "ln -nfs #{fetch(:shared_path)}/config/database.yml #{fetch(:release_path)}/config/database.yml"
#     run "ln -nfs #{fetch(:shared_path)}/config/application.yml #{fetch(:release_path)}/config/application.yml"
#   end
#   after "deploy:finalize_update", "deploy:symlink_config"

#   desc "Make sure local git is in sync with remote."
#     task :check_revision, roles: :web do
#       unless `git rev-parse HEAD` == `git rev-parse master`
#         puts "WARNING: HEAD is not the same as master"
#         puts "Run `git push` to sync changes."
#         exit
#       end
#     end
#     before "deploy", "deploy:check_revision"
# end

#   desc "install the necessary prerequisites"
#     task :bundle_install, :roles => :app do
#       run "cd #{fetch(:release_path)} && bundle install"
#     end
#     after "deploy:update_code", :bundle_install