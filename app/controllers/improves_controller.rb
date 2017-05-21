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

      # if current_user.balance >= 25
      #   unless current_user.reffered.nil?
      #         reffered = current_user.reffered
      #         reffered.balance += 25*0.75
      #         reffered.save
      #     end
          

      #     transfer = Transfer.new
      #     transfer.user_id = current_user.id
      #     transfer.bank_id = Bank.last.id
      #     transfer.summa = 25*0.20
      #     transfer.save            

      #     unless current_user.reffered.nil?
      #       transfer = Transfer.new
      #       transfer.user_id = current_user.reffered.id
      #       transfer.bank_id = Bank.last.id
      #       transfer.summa = 25*0.05
      #       transfer.save
      #     end
          
      #     user = current_user
      #     user.balance = current_user.balance - 25
      #     user.save
