class ConfirmationsController < Devise::ConfirmationsController
  private
  def after_confirmation_path_for(resource_name, resource)
    flash[:balance] = 'Письмо отправлено!'
    profiles_path
  end
end