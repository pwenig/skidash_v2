Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :mountains
    resources :roads

    root to: "mountains#index"
  end

 root to: 'dashboard#index'

 resources :mountains do
  collection do
    get 'forecast'
  end 
 end

 resources :roads, only: [:index] do
  collection do
    get 'alert'
    get 'images'
    get 'speeds'
  end 
 end 

end
