require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
require 'rails/test_unit/railtie'

Bundler.require(*Rails.groups)

module RNAAsAPI
  class Application < Rails::Application
    config.api_only = true
    config.load_defaults 5.1
    config.active_record.schema_format = :sql

    # Custom config
    config.switch_server = config_for(:switch_server)

    config.autoload_paths +=
      %W[ #{config.root}/lib/
          #{config.root}/app/interactors
          #{config.root}/app/interactors/organizers
          #{config.root}/app/interactors/jobs
          #{config.root}/app/solr]
  end
end
