# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'home/index'
  get 'home/about'

  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home#index'
  end
end
