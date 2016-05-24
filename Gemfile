source 'https://rubygems.org'

# gem 'rails', '3.2.12'
gem 'rails', '4.2.6'
gem 'pg'

# gems added under guidance from Railscasts upgrading to Rails 4
gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails','~>5.0.4'
gem 'coffee-rails','~>4.1.1'
gem 'bootstrap-sass'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-ui-rails'


gem 'jquery-rails'
gem 'select2-rails', '~> 4.0.1'
gem 'simple_form', '~> 3.2.1'
gem 'devise'
# gem 'cancan' - replaced by scratch built authorisation
gem 'figaro'
gem 'prawn', '~> 2.1.0'
gem 'prawn-table'
gem 'unicorn'
# gem 'strong_parameters'
gem 'validates_email_format_of'
gem 'acts_as_list'
gem 'pg_search'
gem 'kaminari'

group :development do
# Deploy with Capistrano
  gem 'capistrano', '~> 3.4.0'
  # gem 'rvm-capistrano','~> 1.5.6'
  gem "better_errors", ">= 0.3.2"
  gem "binding_of_caller"
  gem 'quiet_assets'        # turns off asset pipeline log
  gem 'letter_opener'
end

group :test do
  gem 'cucumber-rails','~> 1.4.3', :require => false
end

group :test, :development do
  gem 'rspec-rails','~> 3.4.2'
  gem 'rspec-collection_matchers'
  gem 'database_cleaner','~> 1.5.1'
  # gem 'capybara','~> 2.0.1'         installed as part of cucumber-rails
  gem 'factory_girl_rails','~> 4.6.0'
  gem 'launchy','~> 2.4.3'
  gem 'rack-mini-profiler'
  gem 'selenium-client'
  gem "selenium-webdriver", "~> 2.53.0"
  gem 'simplecov', :require => false
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec', '~> 4.6.4'
end
