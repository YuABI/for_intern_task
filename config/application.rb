require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AsnicaRecipe
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.active_record.belongs_to_required_by_default = false

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.active_record.default_timezone                  = :local
    config.time_zone                                       = 'Tokyo'
    config.i18n.default_locale                             = :ja
    config.i18n.available_locales                          = :ja
    config.encoding                                        = "utf-8"
    config.active_support.escape_html_entities_in_json     = true
    I18n.enforce_available_locales                         = true
    config.i18n.load_path                                 += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.action_view.field_error_proc = proc do |html_tag, _instance|
      html_tag.to_s.html_safe
    end

    config.log_tags = [ lambda {|req| "#{req.cookies['_asnica_recipe_session']}" },:remote_ip  ]
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins "*"
        resource "*",
                 headers: :any,
                 methods: [:get, :post, :options, :head]
      end
    end
  end
end
