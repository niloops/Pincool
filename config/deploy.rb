$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, 'default'
require 'bundler/capistrano'
load 'deploy/assets'

set :application, "Pincool"
set :scm, "git"
set :repository,  "git@github.com:Lilu/Pincool.git"
set :user, "dev"
set :ssh_options, {:forward_agent => true}
set :deploy_via, :remote_cache
set :deploy_to, "/var/pincool"
set :use_sudo, false

role :web, "pincool.me"                          
role :app, "pincool.me"                          
role :db,  "pincool.me", :primary => true 

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path, 'tmp', 'restart.txt')}"
  end
end




















