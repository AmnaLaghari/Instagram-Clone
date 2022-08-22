# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  authenticated do
    root 'users#index'
    resources :search, only: %i[index]
    resource :relationships, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
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
  end

  unauthenticated do
    root 'home#index'
    resources :home, only: %i[index]
  end
end
