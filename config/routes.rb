# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  resources :posts
  devise_for :users
  resources :home
  resources :users
  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home#index'
  end
end
