Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  resources :homepages, :profiles, :avatars, :improves, :orders, :getmoneys, :getbalances, :feedbacks

  scope ":locale", locale: /en|ru/ do
    post 'buyall/:id' => 'improves#buyall', as: 'buyall'

    put 'buyallproviant/:id' => 'profiles#buyallproviant', as: 'buyallproviant'

    post 'buynumb/:id' => 'profiles#buynumb', as: 'buynumb'
    post 'imroveses/:id' => 'improves#imroveses', as: 'imroveses'


    put 'buyaerodrome/:id' => 'improves#buyaerodrome', as: 'buyaerodrome'
    put 'buyradist/:id' => 'improves#buyradist', as: 'buyradist'

    get 'service' => 'homepages#service', as: 'service'
    get 'contact' => 'homepages#contact', as: 'contact'


    root 'homepages#index'
  end

    match '/success' => 'orders#success', via: :get
    match '/fail' => 'orders#fail', via: :get
  
  devise_for :users, 
  # controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  controllers: { confirmations: 'confirmations', omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  
  match "*path", to: redirect("/#{I18n.default_locale}/%{path}"), via: :all 
  match "", to: redirect("/#{I18n.default_locale}/"), via: :all
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'profiles/:id/adduser' => 'profiles#adduser', :as => 'adduser'
end
