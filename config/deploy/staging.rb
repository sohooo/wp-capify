server "localhost", :app
set     :deploy_to, "staging.example.com"

namespace :config do
    task :symlink, :roles => :app do
        run "ln -nfs #{shared_path}/config/wp-config-#{stage}.php #{release_path}/public/wp-config-#{stage}.php"
    end
end

after "deploy:symlink", "config:symlink"
