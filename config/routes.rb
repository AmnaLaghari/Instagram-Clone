# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :home
  resources :users
  resources :likes, only: [:create, :destroy]
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
