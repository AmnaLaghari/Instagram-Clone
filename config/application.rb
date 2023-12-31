# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'active_storage/attached'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InstagramClone
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    ActiveSupport.on_load(:active_record) do
      extend ActiveStorage::Attached::Macros
    end
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.active_job.queue_adapter = :sidekiq
  end
end
