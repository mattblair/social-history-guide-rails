KycGuideRails::Application.routes.draw do
  
  get "about", to: 'static_page#about'
  get "app", to: 'static_page#app'
  #get "nearby", to: 'static_page#nearby'
  get "contact", to: 'static_page#contact'
  get "credits", to: 'static_page#credits'
  #get "suggestions", to: 'static_page#suggestions'
  get "donate", to: 'static_page#donate'
  
  
  
  root :to => "home#index"
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # limit to show for initial launch
  if Rails.env == "production"
    resources :themes, only: :show
    resources :stories, only: :show
    
    # pre-release
    #get "app", to: 'static_page#apppreview'
  end
  
  if Rails.env == "development"
    
    get "nearby", to: 'static_page#nearby'
    
    # dev has access to all http verbs in controllers:
    resources :stories, :guests, :themes, :tidbits
    
    # utility views for content management:
    get '/stories/:id/history', to: 'stories#history'
    get '/themes/:id/needphoto', to: 'themes#needphoto'
    get '/themes/:id/story-text', to: 'themes#docexport'
  end

  authenticated :user do
    root :to => 'home#index'
  end
  
  devise_for :users
  ActiveAdmin.routes(self)
  resources :users
end