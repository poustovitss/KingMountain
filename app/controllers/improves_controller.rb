class ImprovesController < ApplicationController
  def index
    @users = User.all
  end

  def create
    if current_user.balance >= 150
      unless current_user.conductor == true
        user = current_user
        user.balance = current_user.balance - 25
        user.save
        
        user = current_user
        user.conductor = true
        user.save
      end
        flash[:balance] = 'Вы купили улучшение "Проводник"'
    else
        flash[:balance] = 'У вас не достаточно баланса'
    end
    redirect_to :back
  end

  def update 
    if current_user.balance >= 100  
      unless current_user.carrier == true
        user = current_user
        user.balance = current_user.balance - 100
        user.save
        current_user.update_attribute(:carrier, true)
      end
      
      flash[:balance] = 'Вы купили улучшение "Носильщик"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
    redirect_to :back
  end

  def show
  end
end

