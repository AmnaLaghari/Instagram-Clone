# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  resources :posts
  devise_for :users
<<<<<<< Updated upstream
  resources :home
  resources :users
  resource :relationships, only: %i[create destroy]
=======
  resources :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'home_page/index'
  get 'home_page/about'

>>>>>>> Stashed changes
  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home_page#index'
  end
end
