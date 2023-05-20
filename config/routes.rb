Rails.application.routes.draw do
  root to: "home#index"
  resources :comments
  resources :categories
  resources :posts
  resources :roles
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
