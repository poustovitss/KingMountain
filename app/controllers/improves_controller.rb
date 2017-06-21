class ImprovesController < ApplicationController
  def index
    @users = User.all
  end

  def imroveses
    improveses = params[:improveses]

    if improveses[:radistbuy] == "1"
      @system = Systemfinance.last
      ref_balance = Transfer.find_by_user_id(current_user.id)
      if ref_balance.summa >= 50  
        unless current_user.radist == true
          ref_balance.summa = ref_balance.summa - 50
          ref_balance.save

          @system = Systemfinance.last
          if current_user.reffered.nil?
            @system.summa += 50
            @system.save
          else 
            @system.summa += (50 - (50 * 0.05))
            @system.save

            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = 50*0.05
            transfer.save
          end
          @system.save

          current_user.update_attribute(:radist, true)
        end
        flash[:balance] = 'Вы купили улучшение '
      else
        flash[:balance] = 'У вас не достаточно баланса'
      end
    end

    if improveses[:conductorbuy] == "1"
      @system = Systemfinance.last
      ref_balance = Transfer.find_by_user_id(current_user.id)
      if ref_balance.summa >= 500
        unless current_user.conductor == true
          ref_balance.summa = ref_balance.summa - 500
          ref_balance.save

           @system = Systemfinance.last
          if current_user.reffered.nil?
            @system.summa += 500
            @system.save
          else 
            @system.summa += (500 - (500 * 0.05))
            @system.save

            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = 500*0.05
            transfer.save
          end
          @system.save

          user = current_user
          user.conductor = true
          user.save
        end
          flash[:balance] = 'Вы купили улучшение'
      else
          flash[:balance] = 'У вас не достаточно баланса'
      end
    end

    if improveses[:carrierbuy] == "1"
      @system = Systemfinance.last
      ref_balance = Transfer.find_by_user_id(current_user.id)
      if ref_balance.summa >= 200  
        unless current_user.carrier == true
          ref_balance.summa = ref_balance.summa - 200
          ref_balance.save
          
           @system = Systemfinance.last
          if current_user.reffered.nil?
            @system.summa += 200
            @system.save
          else 
            @system.summa += (200 - (200 * 0.05))
            @system.save

            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = 100*0.05
            transfer.save
          end
          @system.save

          current_user.update_attribute(:carrier, true)
        end
        
        flash[:balance] = 'Вы купили улучшение'
      else
        flash[:balance] = 'У вас не достаточно баланса'
      end
    end

    if improveses[:aerodrombuy] == "1"
      @system = Systemfinance.last
      ref_balance = Transfer.find_by_user_id(current_user.id)
      if ref_balance.summa >= 2000  
        unless current_user.aerodrome == true
          ref_balance.summa = ref_balance.summa - 2000
          ref_balance.save

          @system = Systemfinance.last
          if current_user.reffered.nil?
            @system.summa += 2000
            @system.save
          else 
            @system.summa += (2000 - (2000 * 0.05))
            @system.save

            transfer = Transfer.new
            transfer.user_id = current_user.reffered.id
            transfer.bank_id = Bank.last.id
            transfer.summa = 2000*0.05
            transfer.save
          end
          @system.save
          current_user.update_attribute(:aerodrome, true)
        end

        flash[:balance] = 'Вы купили улучшение'
      else
        flash[:balance] = 'У вас не достаточно баланса'
      end
    end
  redirect_to profiles_path
  end

  def create
    @system = Systemfinance.last
    ref_balance = Transfer.find_by_user_id(current_user.id)
    if ref_balance.summa >= 500
      unless current_user.conductor == true
        ref_balance.summa = ref_balance.summa - 500
        ref_balance.save

         @system = Systemfinance.last
        if current_user.reffered.nil?
          @system.summa += 500
          @system.save
        else 
          @system.summa += (500 - (500 * 0.05))
          @system.save

          transfer = Transfer.new
          transfer.user_id = current_user.reffered.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 500*0.05
          transfer.save
        end
        @system.save

        user = current_user
        user.conductor = true
        user.save
      end
        flash[:balance] = 'Вы купили улучшение "Проводник"'
    else
        flash[:balance] = 'У вас не достаточно баланса'
    end
    redirect_to profiles_path
  end

  def buyaerodrome
    @system = Systemfinance.last
    ref_balance = Transfer.find_by_user_id(current_user.id)
    if ref_balance.summa >= 2000  
      unless current_user.aerodrome == true
        ref_balance.summa = ref_balance.summa - 2000
        ref_balance.save

        @system = Systemfinance.last
        if current_user.reffered.nil?
          @system.summa += 2000
          @system.save
        else 
          @system.summa += (2000 - (2000 * 0.05))
          @system.save

          transfer = Transfer.new
          transfer.user_id = current_user.reffered.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 2000*0.05
          transfer.save
        end
        @system.save
        current_user.update_attribute(:aerodrome, true)
      end

      flash[:balance] = 'Вы купили улучшение "Запасной аэродром"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
      redirect_to profiles_path
  end

  def buyradist
    @system = Systemfinance.last
    ref_balance = Transfer.find_by_user_id(current_user.id)
    if ref_balance.summa >= 50  
      unless current_user.radist == true
        ref_balance.summa = ref_balance.summa - 50
        ref_balance.save

        @system = Systemfinance.last
        if current_user.reffered.nil?
          @system.summa += 50
          @system.save
        else 
          @system.summa += (50 - (50 * 0.05))
          @system.save

          transfer = Transfer.new
          transfer.user_id = current_user.reffered.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 50*0.05
          transfer.save
        end
        @system.save

        current_user.update_attribute(:radist, true)
      end
      flash[:balance] = 'Вы купили улучшение "Радист"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
      redirect_to profiles_path
  end

  def buyall
    @system = Systemfinance.last
    ref_balance = Transfer.find_by_user_id(current_user.id)
    if ref_balance.summa >= 3150
      unless current_user.conductor == true && current_user.carrier == true
        ref_balance.summa = ref_balance.summa - 3150
        ref_balance.save

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

       @system = Systemfinance.last
        if current_user.reffered.nil?
          @system.summa += 3150
          @system.save
        else 
          @system.summa += (3150 - (3150 * 0.05))
          @system.save

          transfer = Transfer.new
          transfer.user_id = current_user.reffered.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 3150*0.05
          transfer.save
        end
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
     ref_balance = Transfer.find_by_user_id(current_user.id)
    if ref_balance.summa >= 200  
      unless current_user.carrier == true
        ref_balance.summa = ref_balance.summa - 200
        ref_balance.save
        
         @system = Systemfinance.last
        if current_user.reffered.nil?
          @system.summa += 200
          @system.save
        else 
          @system.summa += (200 - (200 * 0.05))
          @system.save

          transfer = Transfer.new
          transfer.user_id = current_user.reffered.id
          transfer.bank_id = Bank.last.id
          transfer.summa = 100*0.05
          transfer.save
        end
        @system.save

        current_user.update_attribute(:carrier, true)
      end
      
      flash[:balance] = 'Вы купили улучшение "Носильщик"'
    else
      flash[:balance] = 'У вас не достаточно баланса'
    end
    redirect_to profiles_path
  end

  def show
  end
end

