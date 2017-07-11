ActiveAdmin.register Transfer do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :summa, :bank_id

form do |f|
  f.inputs do 
  	f.input :user_id
  	f.input :summa
  	f.input :bank
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
