source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'colorize'
gem 'interactor', '~> 3.1.0'

# Generate logs for elasticsearch
gem 'logstasher'

gem 'pg', '~> 0.21'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.2.0'

gem 'rack-cors'
gem 'ruby-progressbar'
gem 'rubyzip', '~> 1.2.2'
gem 'smarter_csv'
# Gem progress_bar required for displaying progress in rake sunspot:reindex
gem 'progress_bar'

# Sunspot / Solr friends
gem 'sunspot_rails'
gem 'sunspot_solr'

gem 'whenever'
gem 'json'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.7.2'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'mina'
  gem 'mina-whenever'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'rubocop-rspec', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'fuubar'
  gem 'simplecov'
  gem 'simplecov-console'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
