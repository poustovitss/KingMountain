class ProfilesController < ApplicationController
	
  def index
    if user_signed_in?
      if current_user.level == 1 
        @check_button = current_user.refferences.where(level: 1).count
      else
        @check_button = current_user.refferences.where(level: current_user.level - 1).count
      end
    
       if current_user.level == 0 || current_user.level.nil?
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

    if current_user.level == 1 
      check = current_user.refferences.where(level: 1).count
    else
      check = current_user.refferences.where(level: current_user.level - 1).count
    end
    ref_balance = Transfer.find_by_user_id(current_user.id)
    
    if current_user.level <= 0 
      if ref_balance.nil?
        flash[:balance] = 'У вас не достаточно баланса'
      elsif ref_balance.summa >= 50 
        ref_balance.summa = ref_balance.summa - 50
        ref_balance.save

        current_user.level += 1
        current_user.save
        flash[:balance] = "Вы поднялись на #{current_user.level} уровень"
      else
        flash[:balance] = 'У вас не достаточно баланса'
      end
    else
      if current_user.balance >= pay
        if check >= user.level * 10 
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

          if current_user.level <= 0
            ref_balance = Transfer.find_by_user_id(current_user.id)
            ref_balance.summa = ref_balance.summa - pay
            ref_balance.save
          else
            user.balance = current_user.balance - pay
          end
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
    if current_user.level <= 0
      flash[:balance] = 'Что-бы купить провиантов начните игру'
      redirect_to profiles_path
    else
      if current_user.level == 1
        check_proviant = current_user.refferences.where(level: 1).count
      else 
        check_proviant = current_user.refferences.where(level: current_user.level - 1).count
      end

      if check_proviant >= current_user.level * 10
        flash[:balance] = 'У вас уже есть достаточно количество пригласивших'
        redirect_to :back
      else
          start_pay = 25
          start_coefficient = 7.5
          pay = 0
        if current_user.level == 0
          pay = start_pay
        elsif current_user.level == 1
          pay = 187.50
        else
          (current_user.level - 1).times do
            pay = start_pay * start_coefficient
            start_pay = pay
            start_coefficient -= 0.5
          end
        end

      ref_balance = Transfer.find_by_user_id(current_user.id)
      
        if ref_balance.summa >= pay && ref_balance.summa > 0  

          array_proviants = []
          if current_user.level == 1
            b = User.where("reffered_by = 0 AND created_at > ?", current_user.created_at)
            b.each do |proviant|
              if proviant.level == 1
                array_proviants << proviant
              end
            end
          else
            b = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user)

            b.each do |proviant|
              if proviant.level != 0
                array_proviants << proviant
              end
            end
          end


          if array_proviants.first.nil?
            flash[:balance] = 'Нет свободных провиантов'
          else
            b = array_proviants.first
            b.reffered_by=current_user.id
            b.save

            ref_balance.summa = ref_balance.summa - pay
            ref_balance.save

            # user_onl = current_user
            # user_onl.balance = current_user.balance - pay
            # user_onl.save

            @system = Systemfinance.last
            if current_user.reffered.nil?
              @system.summa += pay * 0.25
              @system.save
            else 
              @system.summa += pay * 0.20
              @system.save
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




  def buyallproviant
    if current_user.level == 1
      check_proviant = current_user.refferences.where(level: 1).count
    else 
      check_proviant = current_user.refferences.where(level: current_user.level - 1).count
    end

    if current_user.level <= 0
      flash[:balance] = 'Что-бы купить провиантов начните игру'
      redirect_to profiles_path
    else
      if check_proviant >= current_user.level * 10
        flash[:balance] = 'У вас уже есть достаточно количество пригласивших'
        redirect_to profiles_path
      else
          start_pay = 25
          start_coefficient = 7.5
          pay = 0
        if current_user.level == 0
          pay = start_pay
        elsif current_user.level == 1
          pay = 187.50
        else
          (current_user.level - 1).times do
            pay = start_pay * start_coefficient
            start_pay = pay
            start_coefficient -= 0.5
          end
        end

      ref_balance = Transfer.find_by_user_id(current_user.id)
      total_proviant = User.where("level = 1 AND reffered_by = 0 AND created_at > ?", current_user.created_at).count

        total_proviant = total_proviant * pay
        if ref_balance.nil?  
          flash[:balance] = 'У вас не достаточно баланса'
          redirect_to profiles_path
        elsif ref_balance.summa >= total_proviant && ref_balance.summa > 0
          array_proviants = []
          if current_user.level == 1
            b = User.where("reffered_by = 0 AND created_at > ?", current_user.created_at)
            b.each do |proviant|
              if proviant.level == 1
                array_proviants << proviant
              end
            end
          else
            b = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user)

            b.each do |proviant|
              if proviant.level != 0
                array_proviants << proviant
              end
            end
          end

          circle = array_proviants.count 
          if array_proviants.first.nil?
            flash[:balance] = 'Нет свободных провиантов'
          else
            array_proviants.each do |b|
              b.reffered_by=current_user.id
              b.save

              ref_balance.summa = ref_balance.summa - pay
              ref_balance.save
            end

            # user_onl = current_user
            # user_onl.balance = current_user.balance - pay
            # user_onl.save

            @system = Systemfinance.last
            if current_user.reffered.nil?
              @system.summa += pay * 0.25
              @system.save
            else 
              @system.summa += pay * 0.20
              @system.save
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
          
            unless current_user.reffered.nil?
              reffered = current_user.reffered
              reffered.balance += pay*0.75
              reffered.save
            end
          end
           redirect_to profiles_path
        else
          flash[:balance] = 'У вас не достаточно баланса'
          redirect_to profiles_path
        end
      end
    end
  end

  def buynumb
    if current_user.level == 1
      check_proviant = current_user.refferences.where(level: 1).count
    else 
      check_proviant = current_user.refferences.where(level: current_user.level - 1).count
    end

    if current_user.level <= 0
      flash[:balance] = 'Что-бы купить провиантов начните игру'
      redirect_to profiles_path
    else
      if check_proviant >= current_user.level * 10
        flash[:balance] = 'У вас уже есть достаточно количество пригласивших'
        redirect_to profiles_path
      else
          start_pay = 25
          start_coefficient = 7.5
          pay = 0
        if current_user.level == 0
          pay = start_pay
        elsif current_user.level == 1
          pay = 187.50
        else
          (current_user.level - 1).times do
            pay = start_pay * start_coefficient
            start_pay = pay
            start_coefficient -= 0.5
          end
        end

      ref_balance = Transfer.find_by_user_id(current_user.id)
      summa_for_prov = params[:counts][:size_to_buy]  
      puts pay

        total_proviant = summa_for_prov.to_i * pay
        if ref_balance.nil?  
          flash[:balance] = 'У вас не достаточно баланса'
          redirect_to profiles_path
        elsif ref_balance.summa >= total_proviant && ref_balance.summa > 0

          array_proviants = []
          if current_user.level == 1
            size_for_proviant = params[:counts][:size_to_buy]
            b = User.where("reffered_by = 0 AND created_at > ?", current_user.created_at).limit(size_for_proviant)
            b.each do |proviant|
              if proviant.level == 1
                array_proviants << proviant
              end
            end
          else

          size_for_proviant = params[:counts][:size_to_buy]

            b = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user).limit(size_for_proviant)


            b.each do |proviant|
              if proviant.level != 0
                array_proviants << proviant
              end
            end
          end
          size_for_proviant = params[:counts][:size_to_buy]
          if current_user.level == 1
            prov = User.where("level = 1 AND reffered_by = 0 AND created_at > ?", current_user.created_at)
          else
            prov = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user)
          end
            # prov.each do |pr|
            #   if pr.level != 0
            #     size_for_pr << pr
            #   end
            # end


          size_for = params[:counts][:size_to_buy]
          size_for = size_for.to_i
          # circle = array_proviants.count 

          if array_proviants.first.nil? 
            flash[:balance] = 'Нет свободных провиантов'
          elsif size_for > prov.count
            flash[:balance] = 'На данный момент такого такого кол-ва провиантов'
          elsif size_for < 0
            flash[:balance] = 'Не правильный набор'
          else
            array_proviants.each do |b|
              b.reffered_by=current_user.id
              b.save

              ref_balance.summa = ref_balance.summa - pay
              ref_balance.save
            end

            # user_onl = current_user
            # user_onl.balance = current_user.balance - pay
            # user_onl.save

            @system = Systemfinance.last
            if current_user.reffered.nil?
              @system.summa += pay * 0.25
              @system.save
            else 
              @system.summa += pay * 0.20
              @system.save
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
          
            unless current_user.reffered.nil?
              reffered = current_user.reffered
              reffered.balance += pay*0.75
              reffered.save
            end
            flash[:balance] = 'У вас не достаточно баланса'
          end
           # flash[:balance] = "Вы купили #{size_for} провианта/провиантов" 
           redirect_to profiles_path
        else
          redirect_to profiles_path
        end
      end
    end
  end

  def balanceinfo 
      start_pay = 25
      start_coefficient = 7.5
      pay = 0
    if current_user.level == 0
      pay = start_pay
    elsif current_user.level == 1
      pay = 187.50
    else
      (current_user.level - 1).times do
        pay = start_pay * start_coefficient
        start_pay = pay
        start_coefficient -= 0.5
      end
    end
    @money = pay
  end

  helper_method :balanceinfo
end