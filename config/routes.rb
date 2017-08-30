Rails.application.routes.draw do
 root to: 'dashboard#index'

 resources :mountains do
  collection do
    get 'forecast'
  end 

 end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
