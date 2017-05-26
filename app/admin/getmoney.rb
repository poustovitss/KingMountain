ActiveAdmin.register Getmoney do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :desc, :status, :total, :wallet, :walletfirm, :user_id

form do |f|
	  f.inputs do 
	  	f.input :user
	  	f.input :walletfirm
	  	f.input :wallet
	  	f.input :status, :label => 'Member', :as => :select, :collection => ['Оплачен', 'Обрабатывается', 'Ошибка']
	  end
	  f.actions
	end

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
