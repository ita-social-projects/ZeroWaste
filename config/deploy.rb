# config valid only for current version of Capistrano
# lock '3.5.0'

set :application, "ZeroWaste"
set :repo_url, "git@github.com:ita-social-projects/ZeroWaste.git"

# Deploy to the user's home directory
set :deploy_to, "/home/deploy/#{fetch :application}"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
# set :branch, :master

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push("config/database.yml")

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads", "storage")

set :default_env, {}

set :bundle_path, nil
set :bundle_jobs, 4
set :bundle_without, nil
set :bundle_flags, nil

set :keep_releases, 5

namespace :deploy do
  namespace :assets do
    desc "rake assets:clean"
    task :clean do
      on roles(:web, :app), in: :groups do
        within release_path do
          with rails_env: fetch(:rails_env) do
            execute :rake, "assets:clean"
          end
        end
      end
    end
  end
  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     # Here we can do anything such as:
  #     # within release_path do
  #     #   execute :rake, 'cache:clear'
  #     # end
  #   end
  # end
  desc "Runs rake assets:images:reprocess to recreate paperclip attachments versions"
  task :setup_things do
    on roles(:web, :app), in: :groups do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "assets:images:reprocess" if ENV["IMAGES_RESIZE"]
        end
      end
    end
  end

  desc "Start server"
  task :start_server do
    on roles(:web, :app), in: :groups do
      within release_path do
        with rails_env: fetch(:rails_env) do
          port = ENV.fetch("RAILS_PORT", 8080)
          execute :rails, "s -d -p #{port} -b 0.0.0.0"
        end
      end
    end
  end

  desc "Stop server"
  task :stop_server do
    on roles(:web, :app), in: :groups do
      within release_path do
        with rails_env: fetch(:rails_env) do
          port     = ENV.fetch("RAILS_PORT", 8080)
          sig_term = ENV.fetch("SIG_TERM", 9)
          execute "kill -s #{sig_term} $(ps aux | grep #{port.to_i})"
        end
      end
    end
  end

  desc "Restart server"
  task :restart_server

  before :restart_server, :stop_server
  after :restart_server, :start_server
end

# Reprocess images versions
before "deploy:restart", "deploy:setup_things"
