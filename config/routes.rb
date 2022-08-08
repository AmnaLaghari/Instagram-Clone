# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  resources :posts
  devise_for :users
  resources :home
  resources :users
  resource :relationships, only: %i[create destroy]

  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home_page#index'
  end
end
