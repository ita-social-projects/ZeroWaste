set :user, "ubuntu"

server "51.44.25.104", user: fetch(:user), roles: ["app", "db", "web"], primary: true, port: 22

set :passenger_restart_with_touch, true
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :ssh_options, {
  keys: ["~/.ssh/id_rsa"],
  forward_agent: false,
  auth_methods: ["publickey"]
}

set :stage, :staging
set :rails_env, "staging"

set :branch, :develop
set :rvm_ruby, "3.3.5"
set :rvm_custom_path, "/usr/share/rvm"
