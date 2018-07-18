source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'colorize'
gem 'interactor', '~> 3.0'

# Generate logs for elasticsearch
gem 'logstasher'

gem 'pg', '~> 0.20'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.6'

# Sunspot / Solr friends
gem 'sunspot_rails'
gem 'sunspot_solr'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.7'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

