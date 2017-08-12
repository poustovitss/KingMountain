module Users
  class ConfirmationsController < Devise::ConfirmationsController

    protected

    def after_confirmation_path_for(resource_name, resource)
      flash[:notice] = t('flash.users.confirmation.notice')
      profiles_path
    end
  end
end
