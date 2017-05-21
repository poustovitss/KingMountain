Rails.application.routes.draw do

  ActiveAdmin.routes(self)
 resources :homepages, :profiles, :improves

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'

  # get 'profiles/:id/adduser' => 'profiles#adduser', :as => 'adduser'
end
