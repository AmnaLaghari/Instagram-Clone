# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'home_page/index'
  get 'home_page/about'

  authenticated do
    root 'posts#index'
  end

  unauthenticated do
    root 'home_page#index'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
