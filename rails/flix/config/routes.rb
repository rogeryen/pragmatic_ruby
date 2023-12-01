Rails.application.routes.draw do
  resources :users
  resources :reviews
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "movies#index"
  resources :movies do
    resources :reviews
  end
end
