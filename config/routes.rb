KycGuideRails::Application.routes.draw do
  
  root :to => "home#index"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :stories


  resources :guests


  resources :tidbits


  resources :themes
  
  # this is probably dev only, as a quick way to extract info
  get '/themes/:id/needphoto', to: 'themes#needphoto'

  authenticated :user do
    root :to => 'home#index'
  end
  
  devise_for :users
  ActiveAdmin.routes(self)
  resources :users
end