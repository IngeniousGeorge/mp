set :output, "/var/log/mp-cron.log"

every 1.hour do
  rake "deploy:db_seed"
end