require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"

install_plugin Capistrano::SCM::Git

require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano/passenger"
require "capistrano/yarn"
require "capistrano/rails_tail_log"
require "capistrano/rails"
require "capistrano/rbenv"
require "dotenv"

set :rbenv_type, :user
set :rbenv_ruby, "3.3.3"

Dotenv.load

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
