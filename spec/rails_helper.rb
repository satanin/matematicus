ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      :provider => 'google_oauth2',
      :uid => '123545',
      :info => {
        :email => 'john.doe@test.com',
        :name => 'John'
      }
    })

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
