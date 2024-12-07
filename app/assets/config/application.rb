# config/application.rb

require_relative 'boot'

require "rails"
# Incluye las gemas necesarias en tu aplicación.
# ...

module YourApp
  class Application < Rails::Application
    # Configuraciones predeterminadas de Rails.
    config.load_defaults 6.0

    # Configuración para cargar archivos de traducción desde `app/assets/config/locales`.
    config.i18n.load_path += Dir[Rails.root.join('app/assets/config/locales', '**', '*.yml')]

    # Configurar la zona horaria
    config.time_zone = 'UTC'

    # Configurar los locales disponibles
    config.i18n.available_locales = [:en, :es]

    # Configuración predeterminada de localización
    config.i18n.default_locale = :en

    # Otros ajustes...
  end
end
