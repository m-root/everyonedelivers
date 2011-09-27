EveryoneDelivers::Application.routes.draw do
  resources :deliveries do
    member do
      put :accept
      put :confirm
    end  
  end

  resources :users do
    member do
      put :update_location
      post :clock_in
      post :clock_out
    end
  end

  resources :locations
  resources :packages

  devise_for :users
  match '/' => 'dashboard#index', :as => :root
  match '/journal' => 'journal#index'
  match '/journal/count' => 'journal#count'
  match '/:controller(/:action(/:id))'

end
