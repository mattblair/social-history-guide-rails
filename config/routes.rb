KycGuideRails::Application.routes.draw do
  resources :stories


  resources :guests


  resources :tidbits


  resources :themes


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end