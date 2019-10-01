# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "stones"
set :repo_url, "git@github.com:ashladh/stones.git"

set :ssh_options, { :forward_agent => true, :port => 22 }

set :rvm_type, :system # or :user, depends on your rbenv setup
set :rvm_ruby_version, 'ruby-2.6.4'

set :deploy_to, "/var/www/stones"

set :branch, "production"
set :rails_env, "production"


set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle'
)

set :linked_files, fetch(:linked_files, []).push(
  'config/git_config.yml'
)


namespace :deploy do

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after 'deploy:publishing', 'deploy:restart'

end

before "deploy:assets:precompile", "deploy:yarn_install"

namespace :deploy do
  desc "Run rake yarn install"
  task :yarn_install do
    on roles(:web) do
      within release_path do
        execute("cd #{release_path} && yarn install --silent --no-progress --no-audit --no-optional")
      end
    end
  end
end


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/mongoid.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
