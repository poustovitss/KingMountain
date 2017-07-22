class ProfilesController < ApplicationController
	
  def percentproviant
    if current_user.level == 1
      percentfor = 0.75
    elsif current_user.level == 2
      percentfor = 0.70
    elsif current_user.level == 3
      percentfor = 0.65
    elsif current_user.level == 4
      percentfor = 0.60
    elsif current_user.level == 5
      percentfor = 0.55
    elsif current_user.level == 6
      percentfor = 0.50
    end

    return percentfor
  end

  def getbonus
    unless current_user.skype.nil? && current_user.surname.nil? && current_user.phone.nil? && current_user.country.nil?
     unless current_user.skype == "" && current_user.surname == "" && current_user.phone == "" && current_user.country = ""
      if current_user.bonus == false
        if current_user.ball.nil? 
          current_user.ball = 0
          current_user.ball += 100
          current_user.save
        else
          current_user.ball += 100
          current_user.save
        end
        current_user.update_attribute(:bonus, true)
      else
        flash[:balance] = "Вы уже активировали бонус"
      end
     else 
      flash[:balance] = "Вы не заполнили поля" 
     end
    else 
      flash[:balance] = "Вы не заполнили поля"  
    end
    redirect_to :back
  end

  def index
    if user_signed_in?
      if current_user.level == 1 
        @check_button = current_user.refferences.where(level: 1).count
      else
        @check_button = current_user.refferences.where(level: current_user.level - 1).count
      end
    
       if current_user.level == 0 || current_user.level.nil?
         @button = I18n.t('profile.start')
       else
        @button = I18n.t('profile.next')
       end
    else
     redirect_to new_user_session_path 
    end
  end

  def mobline
    
  end

  def create 
    user = current_user
    refferences_count = current_user.refferences.count 
    
    start_pay = 50
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
      check = current_user.refferences.where(level: 1).count + current_user.inviteds.where(level: 1).count
    else
      check = current_user.refferences.where(level: current_user.level - 1).count + current_user.inviteds.where(level: current_user.level - 1).count
    end

    ref_balance = Transfer.find_by_user_id(current_user.id)
    
    if current_user.level <= 0 
      if ref_balance.nil?
        flash[:balance] = 'У вас не достаточно баланса'
      else
        if ref_balance.summa >= 50
          if current_user.conductor == true
            ref_balance.summa = ref_balance.summa - (50 - (50 * 0.05))
            ref_balance.save
          else
            ref_balance.summa = ref_balance.summa - 50
            ref_balance.save
          end

          current_user.level += 1
          current_user.save

          unless current_user.invited.nil?
            if current_user.invited.transfers.last.nil?
              transfer = Transfer.new
              transfer.user_id = current_user.invited.id
              transfer.bank_id = Bank.last.id
              transfer.summa = 0
              transfer.summa += pay*0.05
              transfer.save
            else
              transfer = current_user.invited.transfers.last
              transfer.summa += pay*0.05
              transfer.save
            end
          end

          unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += pay*0.75
            reffered.save
          end

          @system = Systemfinance.last
          if user.reffered.nil?
            if current_user.conductor == true
              @system.summa += pay * 0.20
              @system.save
            else
              @system.summa += pay * 0.25
            end
          else 
            if current_user.conductor == true
              @system.summa += pay * 0.15
              @system.save
            else
              @system.summa += pay * 0.20
              @system.save
            end
          end
          
          FirstJobJob.set(wait: 1300.minutes).perform_later(current_user)
          flash[:balance] = "Вы поднялись на #{current_user.level} уровень"
        else
          flash[:balance] = 'У вас не достаточно баланса'
        end
      end
    else
      if current_user.balance >= pay
        if check >= user.level * 10 
          unless current_user.invited.nil?
             if current_user.invited.transfers.last.nil?
              transfer = Transfer.new
              transfer.user_id = current_user.invited.id
              transfer.bank_id = Bank.last.id
              transfer.summa = 0
              transfer.summa += pay*0.05
              transfer.save
            else
              transfer = current_user.invited.transfers.last
              transfer.summa += pay*0.05
              transfer.save
            end
          end

          if current_user.level <= 0
            if current_user.conductor == true
              ref_balance = Transfer.find_by_user_id(current_user.id)
              ref_balance.summa = ref_balance.summa - (pay - (pay * 0.05)) 
              ref_balance.save
            else
              ref_balance = Transfer.find_by_user_id(current_user.id)
              ref_balance.summa = ref_balance.summa - pay
              ref_balance.save
            end
          else
            if current_user.conductor == true
              user.balance = current_user.balance - (pay - (pay * 0.05))
            else
              user.balance = current_user.balance - pay
            end
          end
            user.level += 1 

          @system = Systemfinance.last
          if user.reffered.nil?
            if current_user.conductor == true
              @system.summa += pay * 0.20
              @system.save
            else
              @system.summa += pay * 0.25
            end
          else 
            if current_user.conductor == true
              @system.summa += pay * 0.15
              @system.save
            else
              @system.summa += pay * 0.20
              @system.save
            end
          end

          unless current_user.reffered.nil?
            if user.reffered.level <= user.level && user.level > 1 && user.level > 0
              if user.proviant == true
                user.reffered_by = 0
              end
            end
          end

          unless current_user.reffered.nil?
            if current_user.level >= current_user.reffered.level
              current_user.reffered_by = 0
            end
          end
          
          unless current_user.reffered.nil? || current_user.reffered_by == 0
            reffered = current_user.reffered
            reffered.balance += pay*percentproviant
            reffered.save
          end

          user.save
          
          FirstJobJob.set(wait: 1000.minutes).perform_later(current_user)

          flash[:balance] = "Вы поднялись на #{current_user.level} уровень"
        else
          flash[:balance] = "у вас мало провиантов!"
        end
      else
        flash[:balance] = "У вас не достаточно баланса"
      end
    end
    redirect_to :back

    if current_user.level == 7
      current_user.level = 0
      current_user.save
      
      current_user.refferences.each do |winner|
        winner.reffered_by = 0
        winner.save
      end

      current_user.inviteds.each do |inv|
        inv.invited_by = 0
        inv.save
      end
    end
    users = User.where(radist: true)
    users.each do |u|
      RadistMailer.welcome_email(u).deliver_later
    end
  end

  def levelinfo
    '10'
  end

  def summproviant
    start_pay = 50
    start_coefficient = 100
    pay = 0

    if current_user.level == 0
      pay = start_pay
    elsif current_user.level == 1
      pay = 50
    else
      @summs = (50 + ((current_user.level - 1) * 100))
    end
  end

  helper_method :summproviant
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

            current_user.balance += pay*0.75
            current_user.save
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
          start_pay = 50
          start_coefficient = 100
          pay = 0
        if current_user.level == 0
          pay = start_pay
        elsif current_user.level == 1
          pay = 50
        else
          (current_user.level - 1).times do
            pay = start_pay + start_coefficient
            start_pay = pay
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

              current_user.balance += pay*0.75
              current_user.save
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
          start_pay = 50
          start_coefficient = 100
          pay = 0
        if current_user.level == 0
          pay = start_pay
        elsif current_user.level == 1
          pay = 50
        else
          pay = (50 + ((current_user.level - 1) * 100))
        end

      ref_balance = Transfer.find_by_user_id(current_user.id)
      if current_user.carrier == true
        pay = pay - (pay * 0.15)
      end

      summa_for_prov = params[:counts][:size_to_buy]  



        total_proviant = summa_for_prov.to_i * pay
        if ref_balance.nil?
          flash[:balance] = 'У вас не достаточно баланса'
          redirect_to profiles_path
        elsif ref_balance.summa < pay
          flash[:balance] = 'У вас не достаточно баланса'
          redirect_to profiles_path
        elsif ref_balance.summa >= total_proviant && ref_balance.summa > 0

          check_the_nil = params[:counts][:size_to_buy]
          if current_user.level == 1
            kolvo = current_user.refferences.where(level: current_user.level).count + current_user.inviteds.where(level: 1).count
          else 
            kolvo = current_user.refferences.where(level: current_user.level - 1).count + current_user.inviteds.where(level: current_user.level - 1).count
          end

          check_the_prov = check_the_nil.to_i + kolvo
          check_the_provs = current_user.level * 10

          if check_the_nil.to_i <= 0 || check_the_nil.nil? 
            flash[:balance] = 'Введите правильное количество провиантов'
            redirect_to :back
          elsif check_the_prov > check_the_provs
            flash[:balance] = 'Вы не можете купить больше 10 провиантов'
            redirect_to :back
          else
            array_proviants = []
            if current_user.level == 1
              limiter = params[:counts][:size_to_buy]
              limiter = limiter.to_i
              b = User.where("level = 1 AND reffered_by = 0 AND created_at > ?", current_user.created_at).limit(limiter)
              
              b.each do |proviant|
                array_proviants << proviant
              end
            else

              limiter = params[:counts][:size_to_buy]
              limiter = limiter.to_i
              b = User.where(reffered_by: 0, level: current_user.level - 1).all_except(current_user).limit(limiter)              

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
              flash[:balance] = 'На данный момент нет такого кол-ва провиантов'
            elsif size_for < 0
              flash[:balance] = 'Не правильный набор'
            else
              array_proviants.each do |b|
                b.reffered_by=current_user.id
                b.save

                # if current_user.carrier == true 
                #   ref_balance.summa = ref_balance.summa - (pay - (pay * 0.15))
                #   ref_balance.save
                # else
                  ref_balance.summa = ref_balance.summa - pay
                  ref_balance.save
                # end

                start_pay1 = 50
                start_coefficient1 = 7.5

                if current_user.level == 0
                  pay1 = start_pay1
                else
                  (current_user.level - 1).times do 
                    pay1 = start_pay1 * start_coefficient1
                    start_pay1 = pay1
                    start_coefficient1 -= 0.5
                  end
                end

                current_user.balance += start_pay1*percentproviant
                current_user.save
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
            
              flash[:balance] = "Вы купили #{size_for} провианта/провиантов" 
            end
             redirect_to profiles_path
          end
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