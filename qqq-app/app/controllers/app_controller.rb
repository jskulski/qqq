require 'rails/application_controller'

# Loads the javascript app
#
class AppController < Rails::ApplicationController
  def index
    render file: Rails.root.join('public', 'app.html')
  end
end