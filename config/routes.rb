Rails.application.routes.draw do
  devise_for :users
  
  root 'welcome#index'
  
  resources :users do
    resource :profile do
      member do
        put :published_toggle
      end
    end
    collection do
      post :import
    end
  end
  
  resources :groups
end
