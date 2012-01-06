set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "example.com"
set :repository,  "repo_url"

set :scm, :git

set :branch do
  default_tag = `git tag`.split("\n").last

  tag = Capistrano::CLI.ui.ask "Tag to deploy: [#{default_tag}] "
  tag = default_tag if tag.empty?
  tag
end

set :use_sudo, false
set :deploy_via, :remote_cache
set :copy_exclude, [".git", ".DS_Store", ".gitignore", ".gitmodules"]

namespace :shared do
  desc "setup shared folders"
  task :setup, :roles => :app do
    run "mkdir -p #{shared_path}/uploads && chmod g+w #{shared_path}/uploads"
  end

  desc "symlink shared folders"
  task :symlink, :roles => :app do
    run "ln -nvfs #{shared_path}/uploads #{release_path}/public/wp-content/uploads"
  end
end

after "deploy:setup",   "shared:setup"     # setup uploads/ folder
after "deploy:setup",   "bootstrap:config" # create wp-config-template.php
after "deploy:symlink", "shared:symlink"   # symlink uploads/ folder
