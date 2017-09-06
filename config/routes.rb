Rails.application.routes.draw do
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
