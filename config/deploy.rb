require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/whenever'
require 'colorize'

ENV['domain'] || raise('no domain provided'.red)

ENV['to'] ||= 'sandbox'
unless %w[sandbox production].include?(ENV['to'])
  raise("target environment (#{ENV['to']}) not in the list")
end

print "Deploy to #{ENV['to']} environment\n".green

set :commit, ENV['commit']
set :user, 'deploy'
set :application_name, 'rna_api'
set :domain, ENV['domain']

set :deploy_to, "/var/www/rna_api_#{ENV['to']}"
set :rails_env, ENV['to']

set :forward_agent, true
set :port, 22
set :repository, 'git@github.com:etalab/rna_as_api.git'

branch = begin
           case ENV['to']
           when 'production'
             'develop'
             #'master'
           when 'sandbox'
             'develop'
           end
         end

set :branch, branch
ensure!(:branch)

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
set :shared_dirs, fetch(:shared_dirs, []).push(
  'bin',
  'config/environments',
  'log',
  'tmp/pids',
  'tmp/cache',
  'solr/pids'
)

set :shared_files, fetch(:shared_files, []).push(
  'config/database.yml',
  'config/secrets.yml'
)
# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  set :rbenv_path, '/usr/local/rbenv'
  invoke :'rbenv:load'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # Production database has to be setup !
end

desc 'Deploys the current version to the server.'
task :deploy do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    set :bundle_options, fetch(:bundle_options) + ' --clean'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}

        invoke :whenever_update
        invoke :solr
      end

      invoke :passenger
      invoke :warning_info
    end
  end
end

task whenever_update: :remote_environment do
  set :whenever_name, "rna_api_#{ENV['to']}" # default value is based on domain name, and it is used to match in crontab !
  set :bundle_bin, '/usr/local/rbenv/shims/bundle' # with our rbenv config it cannot be found...

  invoke :'whenever:update'
end

task warning_info: :local_environment do
  warning_sign = '\xE2\x9A\xA0'
  comment "#{warning_sign} #{warning_sign} #{warning_sign}".yellow
  comment "#{warning_sign} We assume the first import was done. If not run :".yellow
  comment "RAILS_ENV=#{ENV['to']} bundle exec rake rna_as_api:import_last_monthly_stocks".yellow
  comment "#{warning_sign} #{warning_sign} #{warning_sign}".yellow
end

task solr: :remote_environment do
  comment 'Restarting Solr service'.green
  command "sudo systemctl restart solr_rna_api_#{ENV['to']}"
end

task passenger: :remote_environment do
  comment 'Attempting to start Passenger app'.green
  command %{
  if (sudo passenger-status | grep siade_#{ENV['to']}) >/dev/null
  then
    passenger-config restart-app /var/www/siade_#{ENV['to']}/current
  else
    echo 'Skipping: no passenger app found (will be automatically loaded)'
  fi
  }
end
