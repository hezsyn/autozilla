Rails.application.routes.draw do

  get '/login', to: 'sessions#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'


  root 'categories#index'

  resources :categories do
    resources :systems do
      resources :images do
        resources :notes
      end
    end
  end

  resources :pools
  resources :oses
  resources :users
  resources :clonezilla_versions
  resources :support_stuffs
  resources :autozilla_key_configs

  # Easter egg :D
  get '/ohya!', to: 'randy#savage'

  # Setting up QA routes
  get '/applyQA', to: 'qa#applyQA'
  resources :keyfiles
  resources :qa
  get '/view', to: 'qa#view'


  get '/autozilla_key', to: 'autozilla_key_configs#index'
  get '/autozilla_key/restore', to: 'autozilla_key_configs#restoreKey'
  get '/autozilla_key/selfupdate', to: 'autozilla_key_configs#selfUpdate'

  get '/clonezilla_version/:id/newCZFiles', to: 'clonezilla_versions#populateCZFiles', as: 'populateCZ'

end
