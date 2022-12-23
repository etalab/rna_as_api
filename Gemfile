source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails'

gem 'colorize'
gem 'interactor'

# Generate logs for elasticsearch
gem 'logstasher'

gem 'pg'
gem 'puma'

gem 'rack-cors'
gem 'ruby-progressbar'
gem 'rubyzip'
gem 'smarter_csv'
# Gem progress_bar required for displaying progress in rake sunspot:reindex
gem 'progress_bar'

# Sunspot / Solr friends
gem 'sunspot_rails'
gem 'sunspot_solr'

gem 'json'
gem 'whenever'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'listen'
  gem 'mina'
  gem 'mina-whenever'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
end

group :test do
  gem 'fuubar'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
