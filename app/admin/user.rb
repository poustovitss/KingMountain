ActiveAdmin.register User do

permit_params :name, :email, :password, :invited_by, :reffered_by, :reffered, :confirmed, :balance, :level, :carrier, :conductor, :aerodrome, :radist

	# controller do
	#   def destroy
	#     @user = User.find(params[:id])
	#     if @user == current_user
 #    	 flash[:notice] = "Вы не можете удалить самого себя"
	#       redirect_to admin_dashboard_path
	#  	else
	#  	 @user.destroy
	#  	 flash[:notice] = "Вы успешно удалили пользователя"
	#  	 redirect_to admin_dashboard_path
	#  	end
	#   end 
	# end 

	form do |f|
	  f.inputs do 
	  	f.input :name
	  	f.input :email
	  	f.input :admin
	  	f.input :level
	  	f.input :radist
	  	f.input :carrier
	  	f.input :conductor
	  	f.input :aerodrome
	  	f.input :reffered_by
	  	f.input :invited_by
	  	f.input :balance
	  end
	  f.actions
	end
 

	index do
		selectable_column
		id_column
		column :name
		column :email
		column :reffered_by
		column :reffered
		column :confirmed_at
		column :invited
		column :level
		column :balance
		# column :encrypted_password => Токен
	 	 actions
	end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
