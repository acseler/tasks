# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'factory_girl_rails'
require 'devise'
require 'shoulda/matchers'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/webkit/matchers'
require 'support/capybara'
require 'support/database_cleaner'
require 'support/share_db_connection'
require 'support/facebook_helper'

Capybara.javascript_driver = :webkit
ActiveRecord::Migration.maintain_test_schema!
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/factories"

  OmniAuth.config.test_mode = true

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |c|
    c.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller

  config.include(Capybara::Webkit::RspecMatchers, :type => :feature)
end
