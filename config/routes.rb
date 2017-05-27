Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :homepages, :profiles, :improves, :orders, :getmoneys, :getbalances

  post 'buyall/:id' => 'improves#buyall', as: 'buyall'
  match '/success' => 'orders#success', via: :get
  match '/fail' => 'orders#fail', via: :get

  devise_for :users, controllers: { confirmations: 'confirmations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'

  # get 'profiles/:id/adduser' => 'profiles#adduser', :as => 'adduser'
end
