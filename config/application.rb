require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SkidashV2
  # Application rb
  class Application < Rails::Application
    config.autoload_paths += %W[#{config.root}/lib/modules]
    config.assets.paths <<
      Rails.root.join('vendor', 'assets', 'bower_components')
    config.assets.precompile << /.*.(?:eot|svg|ttf|woff|woff2)$/
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      if File.exist?(env_file)
        YAML.safe_load(File.open(env_file)).each do |key, value|
          ENV[key.to_s] = value
        end
      end
    end
  end
end
