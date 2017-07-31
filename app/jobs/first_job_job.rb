class FirstJobJob < ApplicationJob
  queue_as :default


  def money(user)
		start_pay = 50
	  start_coefficient = 7.5

	  @pay = 0

	  if user.level == 0 || user.level == 1
	    @pay = start_pay
	  else
	    user.level.times do 
	      @pay = start_pay * start_coefficient
	      start_pay = @pay
	      start_coefficient -= 0.5
	    end
	  end 
  	
  	quantity = 0.75
    @percentfor = 0
      user.level.times do 
        @percentfor = quantity
        quantity = quantity - 0.05
      end

    system_user = User.where(level: user.level)

  	if system_user.first.nil?
			user = user.first
			user.reffered_by = 0
			user.save
		else
			system_user = system_user.first
			
			user.reffered_by = system_user.id
			user.save

			system_user.balance += (@pay * @percentfor)
			system_user.save
		end
  end


  def perform(user)
		if user.reffered_by.nil?
			user.reffered_by = 0
			user.save
		elsif user.reffered_by == 0

			money(user)
		end
	end
end