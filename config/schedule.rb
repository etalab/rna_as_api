# Learn more: http://github.com/javan/whenever
set :output, File.join(Whenever.path, 'log', 'rna_api_cron.log')

###### SANDBOX ######
if environment == 'sandbox'
  every 1.days, at: '7:30 am' do
    rake 'rna_as_api:import_last_monthly_stocks'
  end
end

###### PRODUCTION ######
if environment == 'production'
  # CRON Job for single server update, uncomment if you have a single server

  # every 1.day, at: '4:30 am' do
  #  rake 'rna_as_api:import_last_monthly_stocks'
  # end

  # CRON jobs for dual server update, comment out if you have a single server
  # The rake task is launched only if the server is not used, so each server will update every other day
  every 1.day, at: '4:00 am' do
    rake 'rna_as_api:safe_update'
  end
end
