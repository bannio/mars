source 'https://rubygems.org'

# gem 'rails', '3.2.12'
# gem 'rails', '4.2.6'
gem 'rails', '5.1.1'
gem 'pg'

# gems added under guidance from Railscasts upgrading to Rails 4
# gem 'protected_attributes'
# gem 'rails-observers'
# gem 'actionpack-page_caching'
# gem 'actionpack-action_caching'
# gem 'activerecord-deprecated_finders'

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails'
gem 'coffee-rails'
# gem 'bootstrap-sass'
gem 'bootstrap'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'popper_js'
gem 'uglifier'
gem 'jquery-ui-rails'


gem 'jquery-rails'
gem 'select2-rails'
gem 'simple_form'
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
# gem required to support content_tag_for
gem 'record_tag_helper'
gem 'turbolinks'

group :development do
# Deploy with Capistrano
  gem 'capistrano', '~> 3.6', require: false
  gem 'capistrano-rails',   '~> 1.3', require: false
  gem 'capistrano-bundler', '~> 1.2', require: false
  gem 'capistrano-rvm',   '~> 0.1', require: false
  gem "better_errors"
  gem "binding_of_caller"
  # gem 'quiet_assets'        # turns off asset pipeline log - not rails 5 ready
end

group :test do
  gem 'cucumber-rails', :require => false
end

group :test, :development do
  gem 'rails-controller-testing'  #required to keep assigns in controller tests
  gem 'rspec-rails'
  gem 'rspec-collection_matchers'
  gem 'database_cleaner'
  # gem 'capybara','~> 2.0.1'         installed as part of cucumber-rails
  gem 'factory_girl_rails'
  gem 'rack-mini-profiler'
  gem 'selenium-client'
  gem "selenium-webdriver"
  gem 'simplecov', :require => false
  gem 'rb-fsevent', :require => false
  gem 'guard-rspec'
end

group :test, :development, :staging do
  gem "letter_opener"
  gem 'launchy'
end

