class ImprovesController < ApplicationController
  def index
    @users = User.all
  end

  def create
    if current_user.balance >= 150
      unless current_user.conductor == true
        user = current_user
        user.balance = current_user.balance - 150
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

  def buyaerodrome
    if current_user.balance >= 100  
      unless current_user.aerodrome == true
        user = current_user
        user.balance = current_user.balance - 100
        user.save
        current_user.update_attribute(:aerodrome, true)
      end

      flash[:balance] = 'Вы купили улучшение "Запасной аэродром"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
      redirect_to :back
  end

  def buyall
    if current_user.balance >= 350
      unless current_user.conductor == true && current_user.carrier == true
        user = current_user
        user.balance = current_user.balance - 350
        user.save

        user = current_user
        user.carrier = true
        user.save
        

        user = current_user
        user.aerodrome = true
        user.save

        user = current_user
        user.conductor = true
        user.save
        flash[:balance] = 'Вы купили улучшение "Проводник" и "Носильщик"'
      else
        flash[:balance] = 'Вы уже купили улучшения'
      end

    else
        flash[:balance] = 'У вас не достаточно баланса'
    end
    redirect_to profiles_path
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

