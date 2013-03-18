source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'pg'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'bootstrap-sass'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'select2-rails', '~> 3.2.1'
gem 'simple_form', '~> 2.0.4'
gem 'devise'
# gem 'cancan' - replaced by scratch built authorisation
gem 'figaro'
gem 'prawn'
gem 'unicorn'
gem 'strong_parameters'

group :development do
# Deploy with Capistrano
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem "better_errors", ">= 0.3.2"
  gem "binding_of_caller"
  gem 'quiet_assets'        # turns off asset pipeline log
end

group :test do
  gem 'cucumber-rails','~> 1.3.0', :require => false
end

group :test, :development do
  gem 'rspec-rails','~> 2.12.0'
  gem 'database_cleaner','~> 0.9.1'
  # gem 'capybara','~> 2.0.1'         installed as part of cucumber-rails
  gem 'factory_girl_rails','~> 4.1.0'
  gem 'launchy','~> 2.1.2'
  gem 'rack-mini-profiler'
  gem 'selenium-client'
  gem "selenium-webdriver", "~> 2.30.0"
  gem 'simplecov', :require => false
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec'
end

