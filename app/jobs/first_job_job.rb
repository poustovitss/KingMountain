class FirstJobJob < ApplicationJob
  queue_as :default

  def perform(user)
  	# user = current_user

    if user.reffered_by == 0 && user.level > 1
	  system_users = User.where(level: user.level + 1)

	  system_user = system_users.first
	  
	  user.reffered_by = system_user.id
	  user.save
	elsif user.reffered_by == 0 && user.level <= 1
	 	if user.level == 1
	      percentfor = 0.75
	    elsif user.level == 2
	      percentfor = 0.70
	    elsif user.level == 3
	      percentfor = 0.65
	    elsif user.level == 4
	      percentfor = 0.60
	    elsif user.level == 5
	      percentfor = 0.55
	    elsif user.level == 6
	      percentfor = 0.50
	    end

    start_pay = 50
    start_coefficient = 7.5

    pay = 0

    if user.level == 0 || user.level == 1
      pay = start_pay
    else
      user.level.times do 
        pay = start_pay * start_coefficient
        start_pay = pay
        start_coefficient -= 0.5
      end
    end 

		system_user = User.where(level: 1)


			if system_user.first.nil?
				user = user.first
				user.reffered_by = 0
				user.save
			else
				system_user = system_user.first
				
				user.reffered_by = system_user.id
				user.save

				system_user.balance += (pay * percentfor)
				system_user.save
			end
		end
  end
end
