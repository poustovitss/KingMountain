Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :homepages, :profiles, :improves, :orders, :getmoneys, :getbalances

  post 'buyall/:id' => 'improves#buyall', as: 'buyall'

  put 'buyaerodrome/:id' => 'improves#buyaerodrome', as: 'buyaerodrome'
  put 'buyradist/:id' => 'improves#buyradist', as: 'buyradist'

  match '/success' => 'orders#success', via: :get
  match '/fail' => 'orders#fail', via: :get

  devise_for :users, controllers: { confirmations: 'confirmations', omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homepages#index'

  # get 'profiles/:id/adduser' => 'profiles#adduser', :as => 'adduser'
end
