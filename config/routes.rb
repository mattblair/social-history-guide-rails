KycGuideRails::Application.routes.draw do
  resources :tidbits


  resources :themes


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
end