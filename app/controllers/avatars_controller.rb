class AvatarsController < ApplicationController
  def new
    if user_signed_in?
      @avatar = Avatar.new
    else
      redirect_to new_Product_registration_path
    end
  end

  def create
    if user_signed_in?
      @avatar = Avatar.new(avatar_params)
      @avatar.save
      flash[:balance] = "Вы изменили аватарку"
      redirect_to :back
    else
      redirect_to new_user_registration_path, notice: "Вы не вошли на сайт"
    end
  end

  private
   def avatar_params
    params.require(:avatar).permit(:image, :user_id)
   end
end
