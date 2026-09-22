require "rails/all"

module SampleRailsApp
  class Application < Rails::Application
    config.load_defaults 7.1
    config.api_only = true
  end
end
