class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
	before_filter :capture_referal
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def ensure_signup_complete
    # Убеждаемся, что цикл не бесконечный
    return if action_name == 'finish_signup'

    # Редирект на адрес 'finish_signup' если пользователь
    # не подтвердил свою почту
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  private

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in'
      redirect_to login_url
    end
  end

  def capture_referal  
  	session[:referred_by] = params[:referred_by] if params[:referred_by]
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :reffered_by, :proviant])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || profiles_path
  end
end
