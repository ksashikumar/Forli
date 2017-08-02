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
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Forli
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :head, :options]
      end
    end

    # config.middleware.use ActionDispatch::Session::CookieStore
    # config.middleware.use ActionDispatch::Flash

    config.middleware.use Rack::Deflater

    config.action_controller.action_on_unpermitted_parameters = :raise

    config.generators do |generator|
      # Setting active_record as default migration generator
      generator.orm :active_record
    end
    config.session_store = :disabled
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.eager_load_paths += Dir["#{config.root}/lib/"]
    config.autoload_paths   += Dir["#{config.root}/lib/"]

    config.active_job.queue_adapter = :sidekiq
  end
end
