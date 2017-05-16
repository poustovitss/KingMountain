class ProfilesController < ApplicationController
	
  def index

  end

  def update 
  # randombot = rand(1...1000000000)
  randombot = "#{current_user.id}_#{Time.now.to_i}"
    
    if current_user.balance.nil?
      flash[:balance] = 'Не достаточно баланса'
        redirect_to :back
    else
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
        # a = current_user
        # a.reffered.balance += 50 * 0.05
        # current_user.update_attribute(reffered: {balance: })
        
      else
        flash[:balance] = 'Не достаточно баланса'
        redirect_to :back
      end   
    end
  end
  
end


 # def update 
 #  # randombot = rand(1...1000000000)
 #  randombot = "#{current_user.id}_#{Time.now.to_i}"
    
 #    if current_user.balance.nil?
 #      flash[:balance] = 'Не достаточно баланса'
 #        redirect_to :back
 #    else
 #      if current_user.balance >= 50 && current_user.balance > 0
 #        a = current_user  
 #        a.refferences.new(name: "Donate_#{randombot}", email: "#{randombot}@m.r", password: 'yk,Y@&7v`-8n-C3c', reffered_by: current_user.id)
 #        a.balance = a.balance - 50
 #        a.save

 #        reffered = a.reffered
 #        reffered.balance += 50*0.05
 #        reffered.save

 #        # a = current_user
 #        # a.reffered.balance += 50 * 0.05
 #        # current_user.update_attribute(reffered: {balance: })
 #        redirect_to :back
 #      else
 #        flash[:balance] = 'Не достаточно баланса'
 #        redirect_to :back
 #      end   
 #    end
 #  end


  #  def update 
  # # randombot = rand(1...1000000000)
  # randombot = "#{current_user.id}_#{Time.now.to_i}"
    
  #   if current_user.balance.nil?
  #     flash[:balance] = 'Не достаточно баланса'
  #       redirect_to :back
  #   else
  #     if current_user.balance >= 50 && current_user.balance > 0  
  #       b = User.where(reffered_by: 0).all_except(current_user)


  #       if b.first.nil?
  #         flash[:balance] = 'Нет свободных провиантов'
  #       else
  #         b = b.first
  #         b.reffered_by=current_user.id
  #         b.save
            
  #         b = current_user
  #         b.balance = current_user.balance - 50
  #         b.save
          
  #         unless current_user.reffered.nil?
  #           reffered = current_user.reffered
  #           reffered.balance += 50*0.80
  #           reffered.save
  #         end
  #       end
  #       redirect_to :back
  #       # a = current_user
  #       # a.reffered.balance += 50 * 0.05
  #       # current_user.update_attribute(reffered: {balance: })
        
  #     else
  #       flash[:balance] = 'Не достаточно баланса'
  #       redirect_to :back
  #     end   
  #   end
  # end