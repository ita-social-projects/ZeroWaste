#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rake db:drop
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake assets:precompile
bundle exec rake assets:clean
