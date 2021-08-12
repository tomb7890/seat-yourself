Rails.application.routes.draw do

  resources :restaurants do
    resources :reservations, only: [ :show, :create, :destroy ]
  end
  resources :users, only: [:new, :create, :show] 

  resources :categories, only: [:index, :show]



  resources :sessions, only: [:new, :create, :destroy]



  get 'logout' => 'sessions#destroy'
  get 'login' => 'sessions#new'


  root "restaurants#index"
  # root restaurants_path
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
