# Learn more: http://github.com/javan/whenever
set :output, File.join(Whenever.path, 'log', 'rna_api_cron.log')

every 1.day, at: '4:00 am' do
  rake 'rna_as_api:import_last_monthly_stocks'
end
