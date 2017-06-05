class ProfilesController < ApplicationController
	
  def index
    # FirstJobJob.perform_later 1,2,3 
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
        pay = start_pay * start_coefficient
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

        unless current_user.reffered.nil?
          unless current_user.proviant == true
            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = pay*0.05
            transfer.save
          end
        end

        user.balance = current_user.balance - pay
        user.level += 1 

        @system = Systemfinance.last
        if user.reffered.nil?
          @system.summa += pay * 0.25
          @system.save
        else 
          @system.summa += pay * 0.20
          @system.save
        end

        unless current_user.reffered.nil?
          if user.reffered.level <= user.level && user.level > 1 && user.level > 0
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
    FirstJobJob.set(wait: 24.hours).perform_later(current_user)

    if current_user.level == 10
      bank = Bank.last
      bank.active = false
      bank.save
    end
    users = User.where(radist: true)
    users.each do |u|
      RadistMailer.welcome_email(u).deliver_later
    end
  end

  def levelinfo
    '10'
  end

  helper_method :levelinfo

  def update 
    if current_user.refferences.count == 10
      flash[:balance] = 'У вас уже есть достаточно количество пригласивших'
      redirect_to :back
    else
        start_pay = 25
        start_coefficient = 7.5
        pay = 0
      if current_user.level == 0
        pay = start_pay
      else
        (current_user.level - 1).times do
          pay = start_pay * start_coefficient
          start_pay = pay
          start_coefficient -= 0.5
        end
      end

      if current_user.balance >= pay && current_user.balance > 0  
      b = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user)

      array_proviants = []
      b.each do |proviant|
        if proviant.level != 0
          array_proviants << proviant
        end
      end


        if array_proviants.first.nil?
          flash[:balance] = 'Нет свободных провиантов'
        else

          b = array_proviants.first
          b.reffered_by=current_user.id
          b.save
          
          b = current_user
          b.balance = current_user.balance - pay
          b.save

          @system = Systemfinance.last
          if current_user.reffered.nil?
            @system.summa += pay * 0.25
            @system.save
          else 
            @system.summa += pay * 0.20
            @system.save
          end

          # transfer = Transfer.new
          # transfer.user_id = current_user.id
          # transfer.bank_id = Bank.last.id
          # transfer.summa = pay*0.20
          # transfer.save 

          unless current_user.reffered.nil?
            unless current_user.proviant == true
              transfer = Transfer.new
              transfer.user_id = current_user.reffered.id
              transfer.bank_id = Bank.last.id
              transfer.summa = pay*0.05
              transfer.save
            end
          end
        
          unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += pay*0.75
            reffered.save
          end
        end
         redirect_to :back
      else
        flash[:balance] = 'У вас не достаточно баланса'
        redirect_to :back
      end
    end
  end
end