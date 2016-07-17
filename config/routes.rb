Rails.application.routes.draw do
  resources :sessions, only: [:new, :create]
  resources  :messages, only: [:index, :new, :create]
  delete '/logout' => 'sessions#destroy'  
  root "users#index"
  #resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
  	resources :messages
  end
  resources :messages do
  	collection do
    	get :sent
    	get :received
  	end
  end
end
