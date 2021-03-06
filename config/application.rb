require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Resonanz
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib)

    config.active_record.schema_format = :sql
    config.active_record.include_root_in_json = false

    config.time_zone = 'Moscow'

    # Redis cache backend
    # config.cache_store = :redis_store, "redis://localhost:6379/0/cache"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru

    config.assets.precompile += %w( conversations.js conversations.css )
  end

  Redis = Redis.new
end
