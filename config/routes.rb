KycGuideRails::Application.routes.draw do
  
  get "about", to: 'static_page#about'  
  get "nearby", to: 'static_page#nearby'
  get "contact", to: 'static_page#contact'
  get "credits", to: 'static_page#credits'
  get "suggestions", to: 'static_page#suggestions'
  get "donate", to: 'static_page#donate'

  root :to => "home#index"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :stories


  resources :guests


  resources :tidbits


  resources :themes
  
  # this is probably dev only, as a quick way to extract info
  get '/themes/:id/needphoto', to: 'themes#needphoto'
  get '/themes/:id/docexport', to: 'themes#docexport'

  authenticated :user do
    root :to => 'home#index'
  end
  
  devise_for :users
  ActiveAdmin.routes(self)
  resources :users
end