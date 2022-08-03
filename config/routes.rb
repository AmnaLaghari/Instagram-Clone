# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users
  resources :home

  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home#index'
  end
end
