class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :set_locale
	before_filter :capture_referal, if: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_online

  helper_method :all_who_are_in_touch
  
  def ensure_signup_complete
    # Убеждаемся, что цикл не бесконечный
    return if action_name == 'finish_signup'

    # Редирект на адрес 'finish_signup' если пользователь
    # не подтвердил свою почту
    if current_user && !current_user.email_verified?
      redirect_to finish_signup_path(current_user)
    end
  end

  # возвращает кол-во онлайн юзеров
  # если 'redis' отключен/не работает, возвращает 15. (с точкой, это типа намек)
  def all_who_are_in_touch
    begin
      $redis_onlines.keys.count
    rescue Redis::CannotConnectError
      return '15.'
    end
  end

  private

  # отправляет 'id' юзера в редис как залогиненного
  # если в течении 10 минут не обновил страничку то удаляется с базы 'redis'
  def set_online
    begin
      if !!current_user
        $redis_onlines.set( current_user.id, nil, ex: 10*60 ) #здесь нужно 10 изменить если хотите другой интервал
      end
    rescue Redis::CannotConnectError => e
      # p e.message
    end

  end

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options = {})
   { locale: I18n.locale }.merge options
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = 'Please log in'
      redirect_to login_url
    end
  end

  def capture_referal  
  	session[:invited_by] = params[:invited_by] if params[:invited_by]
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :surname, :skype, :phone, :country, :reffered_by, :proviant, :invited_by])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :surname, :skype, :phone, :country])
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || profiles_path
  end
end
