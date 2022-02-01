# frozen_string_literal: true

require_relative 'boot'

# Load env vars before Rails is loaded
require 'aws-sdk-secretsmanager'
require 'json'

if ENV['AWS_REGION'] && ENV['AWS_SECRET_ARN']
  client = Aws::SecretsManager::Client.new(region: ENV['AWS_REGION'])
  get_secret_value_response = client.get_secret_value(secret_id: ENV['AWS_SECRET_ARN'] )
  secret = get_secret_value_response.secret_string 
  ENV["DB_USERNAME"] = JSON.parse(secret)['username'] 
  ENV["DB_PASSWORD"] = JSON.parse(secret)['password'] 
  ENV["DB_HOST"]    = JSON.parse(secret)['host'] 
  ENV["DB_PORT"]    = JSON.parse(secret)['port'] 
  puts "Using #{ENV["DB_USERNAME"]}"

elsif !ENV['AWS_SECRET_ARN']
  puts "AWS_SECRET_ARN has been set. Secrets will not be loaded from AWS."

elsif !ENV['AWS_REGION']
  puts "AWS_REGION not set. Secrets will not be loaded from AWS."
end

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
#require 'active_storage/engine'
require 'action_controller/railtie'
# require "action_mailer/railtie"
#require 'action_mailbox/engine'
#require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Usbapi
  class Application < Rails::Application
    config.load_defaults 7.0
    config.generators.system_tests = nil
    config.active_job.queue_adapter = :sidekiq
  end
end
