set :application, "stones"
set :repo_url, "git@github.com:ashladh/stones.git"

set :ssh_options, { :forward_agent => true, :port => 22 }

set :rbenv_type, :system # or :user, depends on your rbenv setup
set :rbenv_ruby, File.read('.ruby-version').strip

set :deploy_to, "/var/www/stones"

set :branch, "production"
set :rails_env, "production"


set :linked_dirs, fetch(:linked_dirs, []).push(
  'log',
  'tmp/pids',
  'tmp/cache',
  'tmp/sockets',
  'vendor/bundle',
)
set :linked_files, fetch(:linked_files, []).push(
  'config/host.yml',
  'config/secrets.yml',
  'config/mongoid.yml'
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
