class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_filter :capture_referal
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  private

  def capture_referal  
  	session[:referred_by] = params[:referred_by] if params[:referred_by]
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :reffered_by])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || profiles_path
  end
end
