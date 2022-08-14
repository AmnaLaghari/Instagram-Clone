# frozen_string_literal: true

Rails.application.routes.draw do
  get 'search', to: 'search#index'
  post "requests/accept_request", to: "requests#accept_request", as: "accept_req"
  devise_for :users
  resources :home, only: %i[index]
  resource :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  resources :requests, only: %i[create destroy index]
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
