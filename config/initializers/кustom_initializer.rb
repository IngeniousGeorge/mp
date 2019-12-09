# DOT ENV
# Dotenv.load Rails.root.join('.env') unless Rails.env.production? 

# Assets

# Lib folder
# Rails.application.config.autoload_paths += %W(#{config.root}/lib)

# Image Processing
Rails.application.config.active_storage.variant_processor = :vips

# Time Zone
Rails.application.config.time_zone = 'Europe/Paris'

# Generators
Rails.application.config.generators do |g|
  g.test_framework :rspec
  g.controller_specs true
  g.model_specs true
  g.helper_specs false
  g.view_specs false
  g.routing_specs false
  g.request_specs false
  g.fixtures true
  g.scaffold_stylesheet false
  g.helper false
  g.assets false
end

# Internationalization
I18n.available_locales = [:en, :fr]
I18n.default_locale = :en
Rails.application.config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
Rails.application.config.i18n.fallbacks = [I18n.default_locale]

# Active Admin
ActiveAdmin.setup do |config|
  # config.default_namespace = ENV['ADMIN_PATH'].to_sym

  config.comments_menu = false

  ActiveAdmin::ResourceController.class_eval do
    def find_resource
      resource_class.is_a?(FriendlyId) ? scoped_collection.friendly.find(params[:id]) : scoped_collection.find(params[:id])
    end
  end
end

# Categories
require 'categorize'
Categorize.define_all_as_hash if defined?(Category)