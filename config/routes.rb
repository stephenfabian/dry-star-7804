Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :doctors do
    resources :patients, only: [:update]
  end

  resources :patients, only: [:index]
  resources :hospitals, only: [:show]
end
