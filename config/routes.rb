# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  # resources :users do
  #   resources :posts
  # end
  # root 'home_page#index'
  # get 'users/index'
  # get '/users', to: 'home_page#index'
  devise_for :users
  resources :home

  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home#index'
  end
end
