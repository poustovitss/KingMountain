class ProfilesController < ApplicationController
	
  def index
     if current_user.level <= 0 
       @button = 'Начать игру'
     else
      @button = 'Перейти на следущий уровень'
     end 

  end

  def create 
    u = current_user.refferences.count 
    b = current_user
    #============================================
      if u >= 10 && b.level == 1 && b.balance >= 187.50
        unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += 187.50*0.80
            reffered.save
        end
        b.balance = current_user.balance - 187.50
        b.level += 1
        b.save
    #============================================
      elsif u >= 20 && b.level == 2 && b.balance >= 1312.50
         unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += 1312.50*0.80
            reffered.save
        end
        b.balance = current_user.balance - 1312.50
        b.level += 1
        b.save
    #============================================

    #============================================

    #============================================

    #============================================      
      elsif b.level == 0 && b.balance >= 25
        unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += 25*0.80
            reffered.save
        end
        b.balance = current_user.balance - 25
        b.level += 1
        b.save

      else
        flash[:balance] = 'У вас не достаточно приглашенных или баланса'
      end
    redirect_to :back
  end


  def update 
      if current_user.balance >= 50 && current_user.balance > 0  
        b = User.where(reffered_by: 0).all_except(current_user)


        if b.first.nil?
          flash[:balance] = 'Нет свободных провиантов'
        else
          b = b.first
          b.reffered_by=current_user.id
          b.save
            
          b = current_user
          b.balance = current_user.balance - 50
          b.save
          
          unless current_user.reffered.nil?
            reffered = current_user.reffered
            reffered.balance += 50*0.80
            reffered.save
          end
        end
        redirect_to :back
        
      else
        flash[:balance] = 'Не достаточно баланса'
        redirect_to :back
      end
    end
end