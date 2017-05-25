Rails.application.routes.draw do

  root 'categories#index'

  resources :categories do
    resources :categories, as: :sublevel_1, path: "SubLevel_1" do
      resources :categories, as: :sublevel_2, path: "SubLevel_2" do
        resources :categories, as: :sublevel_3, path: "SubLevel_3" do
          resources :categories, as: :sublevel_4, path: "SubLevel_4" do
            resources :systems do
              resources :images
            end
          end
        end
      end
    end
  end

  resources :pools, only: [:index, :new, :edit, :update, :status]
  resources :oses
  resources :users

end
