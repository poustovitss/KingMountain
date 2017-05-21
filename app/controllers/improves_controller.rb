class ImprovesController < ApplicationController
  def index
    @users = User.all
  end

  def update 
    if current_user.carrier == true
      current_user.update_attribute(:carrier, false)
      flash[:balance] = 'Вы деактивировали улучшение "Носильщик"'
    else
      if current_user.balance >= 25
        unless current_user.reffered.nil?
              reffered = current_user.reffered
              reffered.balance += 25*0.75
              reffered.save
          end
          

          transfer = Transfer.new
          transfer.user_id = current_user.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 25*0.20
          transfer.save            

          unless current_user.reffered.nil?
            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = 25*0.05
            transfer.save
          end
          
          user = current_user
          user.balance = current_user.balance - 25
          user.save

        current_user.update_attribute(:carrier, true)
        flash[:balance] = 'Вы купили улучшение "Носильщик"'
      else
        flash[:balance] = 'У вас не достаточно баланса'
      end
    end
    redirect_to :back
  end

  def show
  end
end
