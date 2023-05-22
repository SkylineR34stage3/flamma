Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root to: "home#index"
  resources :categories
  resources :posts do
    resources :comments, only: [:create]
    collection do
      get :filter_by_category
      post :search
    end
  end
  resources :roles
  resources :users

  get "post_pdf/:id" => "pdf_download#export_pdf", as: "post_pdf"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
