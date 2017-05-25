class FirstJobJob < ApplicationJob
  queue_as :default

  def perform(user)
  	# user = current_user

    if user.reffered_by == 0
	  system_users = User.where(level: user.level + 1)
	  system_user = system_users.first
	  
	  user.reffered_by = system_user.id
	  user.save
	end
  end
end
