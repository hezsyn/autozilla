Rails.application.routes.draw do

  root 'categories#index'

  resources :categories do
    resources :systems do
      resources :images
    end
  end

  resources :pools, :oses, :users
end
