Rails.application.routes.draw do

  resources :restaurants do
    resources :reservations, only: [ :show ]
  end

  resources :users, only: [:new, :create, :edit, :update, :destroy, :show ]

  root "restaurants#index"
  # root restaurants_path
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
