require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/scm/git"

install_plugin Capistrano::SCM::Git

require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano/passenger"
require "capistrano/rails_tail_log"
require "capistrano/rails"
require "capistrano/rvm"
# require "capistrano/rbenv"

Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
