KycGuideRails::Application.routes.draw do
  
  root :to => "home#index"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :stories


  resources :guests


  resources :tidbits


  resources :themes


  authenticated :user do
    root :to => 'home#index'
  end
  
  devise_for :users
  ActiveAdmin.routes(self)
  resources :users
end