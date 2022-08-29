# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resource :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  get :search, controller: :users
  resources :requests, only: %i[create destroy index] do
    member do
      post :edit
    end
  end
  resources :users do
    resources :stories, only: %i[create destroy new index show]
  end
  resources :posts do
    resources :comments
  end
  resources :home, only: %i[index]
  authenticated do
    root 'users#index'
  end

  unauthenticated do
    root 'home#index'
  end
end
