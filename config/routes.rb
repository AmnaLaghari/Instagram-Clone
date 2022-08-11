# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :home, only: %i[index]
  resource :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :users do
    resources :stories, only: %i[create destroy new index show]
  end
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
