# frozen_string_literal: true

Rails.application.routes.draw do
  get 'comments/index'
  get 'comments/show'
  get 'comments/edit'
  get 'comments/delete'
  resources :posts
  devise_for :users
  resources :home
  resources :users
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
