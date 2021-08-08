Rails.application.routes.draw do

  resources :restaurants do
    resources :reservations, only: [ :show ]
  end

  resources :categories, only: [:index, :show]

  resources :users, only: [:new, :create, :edit, :update, :destroy, :show ]

  resources :sessions, only: [:new, :create, :destroy]

  root "restaurants#index"
  # root restaurants_path
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
