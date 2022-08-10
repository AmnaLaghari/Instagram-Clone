# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :home, only: %i[index]
  resources :users
<<<<<<< HEAD
  resource :relationships, only: %i[create destroy]
=======
  resources :likes, only: [:create, :destroy]
>>>>>>> Like implmentation
  resources :posts do
    resources :comments
  end
  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home#index'
  end
end
