require_relative 'boot'
require 'rails/all'
require 'dotenv'

Bundler.require(*Rails.groups)
Dotenv.load('onlinepay.env')

module Kingofmountain
  class Application < Rails::Application
    config.i18n.default_locale = :ru
    config.active_record.raise_in_transactional_callbacks = true
  end
end
