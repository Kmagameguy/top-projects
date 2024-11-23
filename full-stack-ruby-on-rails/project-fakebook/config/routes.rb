Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show] do
    resources :friend_requests, only: [:create, :destroy, :index]
  end

  resources :friend_requests, only: [:destroy]

  # Defines the root path route ("/")
  # root "articles#index"
  root "users#show"
end
