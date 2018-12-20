Rails.application.routes.draw do

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

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
  resources :support_stuffs, only: [:index, :update]
  resources :autozilla_key_configs
  resources :sessions, only: [:index, :create, :edit, :update]
  resources :locations, only: [:index, :create, :update]

  # Easter egg :D
  get '/ohya!', to: 'randy#savage'

  # Setting up QA routes
  get '/applyQA', to: 'qa#applyQA'
  resources :keyfiles
  get '/qa', to: 'qa#qa'
  get '/view', to: 'qa#view'
  get '/qa_results', to: 'qa#index'
  post '/qa_results', to: 'qa#create'
  get '/qa_results/:id', to: 'qa#show', as: 'view_results'

  get '/autozilla_key', to: 'autozilla_key_configs#index'
  get '/autozilla_key/restore', to: 'autozilla_key_configs#restoreKey'
  get '/autozilla_key/selfupdate', to: 'autozilla_key_configs#selfUpdate'
  get '/clonezilla_version/:id/newCZFiles', to: 'clonezilla_versions#populateCZFiles', as: 'populateCZ'

  # Switching status between enable and disable
  get '/clonezilla_version/:id/changeStatus', to: 'clonezilla_versions#changeStatus', as: 'changeCZStatus'
  get '/order_group/:id/changeStatus', to: 'pools#changeStatus', as: 'changePoolStatus'
  get '/operating_system/:id/changeStatus', to: 'oses#changeStatus', as: 'changeOSStatus'
  get '/locations/:id/changeStatus', to: 'locations#changeStatus', as: 'changeLocStatus'

  # Setting default
  get '/locations/:id/changeDefault', to: 'locations#changeDefault', as: 'changeLocDefault' 
  get '/clonezilla/:id/changeDefault', to: 'clonezilla_versions#changeDefault', as: 'changeCZDefault' 
end
