require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FirstRoutesAndControllers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # By default, Rails protects against cross-site request forgery (CSRF) by 
    # checking the authenticity of a certain token for POST requests. We won't 
    # worry about that for now. Just for this assignment, add the line: 
    config.action_controller.default_protect_from_forgery = false
    # Then you won't need to include the authenticity token in your POST params

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
