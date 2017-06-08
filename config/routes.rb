Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'


  root 'categories#index'

  resources :categories do
    resources :systems do
      resources :images
    end
  end

  resources :pools, only: [:index, :new, :edit, :update, :status]
  resources :oses
  resources :users

  get '/ohya!', to: 'randy#savage'

end
