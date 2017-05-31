class ImprovesController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @system = Systemfinance.last
    if current_user.balance >= 150
      unless current_user.conductor == true
        user = current_user
        user.balance = current_user.balance - 150
        user.save

        @system.summa += 150
        @system.save
        
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
    @system = Systemfinance.last
    if current_user.balance >= 100  
      unless current_user.aerodrome == true
        user = current_user
        user.balance = current_user.balance - 100
        user.save
        @system.summa += 100
        @system.save
        current_user.update_attribute(:aerodrome, true)
      end

      flash[:balance] = 'Вы купили улучшение "Запасной аэродром"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
      redirect_to :back
  end

  def buyradist
    @system = Systemfinance.last
    if current_user.balance >= 100  
      unless current_user.radist == true
        user = current_user
        user.balance = current_user.balance - 100
        user.save
        @system.summa += 100
        @system.save
        current_user.update_attribute(:radist, true)
      end
      flash[:balance] = 'Вы купили улучшение "Радист"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
      redirect_to :back
  end

  def buyall
    @system = Systemfinance.last
    if current_user.balance >= 450
      unless current_user.conductor == true && current_user.carrier == true
        user = current_user
        user.balance = current_user.balance - 450
        user.save

        user = current_user
        user.carrier = true
        user.save

        user = current_user
        user.radist = true
        user.save
        

        user = current_user
        user.aerodrome = true
        user.save

        user = current_user
        user.conductor = true
        user.save

        @system.summa += 450
        @system.save
        flash[:balance] = 'Вы купили все улучшения'
      else
        flash[:balance] = 'Вы уже купили улучшения'
      end

    else
        flash[:balance] = 'У вас не достаточно баланса'
    end
    redirect_to profiles_path
  end

  def update 
    @system = Systemfinance.last
    if current_user.balance >= 100  
      unless current_user.carrier == true
        user = current_user
        user.balance = current_user.balance - 100
        user.save
        @system.summa += 100
        @system.save
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

