# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

production1 = 'http://production1.entreprise.data.gouv.fr'
production2 = 'http://production2.entreprise.data.gouv.fr'

domains = [production1, production2]

task :setup do
  domains.each do |domain|
    sh "mina setup domain=#{domain}"
  end
end

task :deploy do
  domains.each do |domain|
    sh "mina deploy domain=#{domain}"
  end
end
