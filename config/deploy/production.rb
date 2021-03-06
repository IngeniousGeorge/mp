# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
server "157.230.109.26", user: "deploy", roles: %w{app db web}


# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }

after "deploy:finished", :copy_files
after "deploy:finished", :db_seed

namespace :deploy do
  desc "Copy gitignored files"
  task :copy_files do
    on roles(:app) do
      run_locally do
        execute "scp /home/ig/Code/mp/keyfile.json deploy@157.230.109.26:#{current_path}/keyfile.json"
      end
    end
  end
end

namespace :deploy do
  desc 'DB seed'
  task :db_seed do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end

namespace :db do
  desc 'DB drop'
  task :drop do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:drop DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        end
      end
    end
  end
end

namespace :db do
  desc 'DB migrate'
  task :migrate do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:migrate'
        end
      end
    end
  end
end

namespace :db do
  desc 'DB seed'
  task :seed do
    on primary :db do
      within release_path do
        with rails_env: fetch(:stage) do
          execute :rake, 'db:seed'
        end
      end
    end
  end
end