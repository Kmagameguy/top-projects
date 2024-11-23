Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users
  resources :events
  resources :event_attendances, only: [:create, :destroy]
  get 'past_events', to: 'events#past_events'

  root "events#index"
end
