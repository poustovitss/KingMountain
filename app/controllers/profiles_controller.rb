class ProfilesController < ApplicationController
	
  def index
    if user_signed_in?
       if current_user.level <= 0 
         @button = 'Начать игру'
       else
        @button = 'Перейти на следущий уровень'
       end
    else
     redirect_to new_user_session_path 
    end
  end

  def create 
    user = current_user

  

    refferences_count = current_user.refferences.count 
    

    start_pay = 25
    start_coefficient = 7.5

    pay = 0

    if user.level == 0
      pay = start_pay
    else
      current_user.level.times do 
        pay += start_pay * start_coefficient
        start_pay = pay
        start_coefficient -= 0.5
      end
    end

    if user.balance >= pay
      if user.refferences.where(level: user.level - 1).count >= user.level * 10 
        unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += pay*0.75
            reffered.save
        end
        

        transfer = Transfer.new
        transfer.user_id = current_user.id
        transfer.bank_id = Bank.last.id
        transfer.summa = pay*0.20
        transfer.save            

        unless current_user.reffered.nil?
          transfer = Transfer.new
          transfer.user_id = current_user.reffered.id
          transfer.bank_id = Bank.last.id
          transfer.summa = pay*0.05
          transfer.save
        end

        user.balance = current_user.balance - pay
        user.level += 1
        unless current_user.reffered.nil?
          if user.reffered.level <= user.level
            user.reffered_by = 0
          end
        end
        user.save
        flash[:balance] = "Вы поднялись на #{current_user.level} уровень"
      else
        flash[:balance] = "у вас мало провиантов!"
      end
    else
      flash[:balance] = "У вас не достаточно баланса"
    end
    redirect_to :back
  end

  def levelinfo
    '10'
  end

  helper_method :levelinfo

  def update 
      if current_user.balance >= 50 && current_user.balance > 0  
        b = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user)


        if b.first.nil?
          flash[:balance] = 'Нет свободных провиантов'
        else
          b = b.first
          b.reffered_by=current_user.id
          b.save
            
          b = current_user
          b.balance = current_user.balance - 50
          b.save

          transfer = Transfer.new
          transfer.user_id = current_user.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 50*0.20
          transfer.save 

          unless current_user.reffered.nil?
            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = 50*0.05
            transfer.save
          end
                    
          unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += 50*0.75
            reffered.save
          end
        redirect_to :back
        
      else
        flash[:balance] = 'У вас не достаточно баланса'
        redirect_to :back
      end
    end
end