require "capistrano/yarn"

set :user, "deploy"
set :rbenv_type, :user

server "185.233.37.137", user: fetch(:user), roles: ["app", "db", "web"], primary: true, port: 22

set :passenger_restart_with_touch, true
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :ssh_options, {
  keys: ["~/.ssh/id_rsa"],
  forward_agent: false,
  auth_methods: ["publickey"]
}

set :stage, :production
set :rails_env, "production"

set :branch, :master
set :rbenv_ruby, "3.3.5"
