class ImprovesController < ApplicationController
  def index
    @users = User.all
  end

  def update 
    if current_user.carrier == true
      current_user.update_attribute(:carrier, false)
      flash[:balance] = 'Вы деактивировали улучшение "Носильщик"'
    else
      current_user.update_attribute(:carrier, true)
      flash[:balance] = 'Вы купили улучшение "Носильщик"'
    end
    redirect_to :back
  end

  def show
  end
end
