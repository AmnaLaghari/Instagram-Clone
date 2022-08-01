# frozen_string_literal: true

Rails.application.routes.draw do
  # get 'posts/index'
  # get 'posts/edit'
  # get 'posts/show'
  # get 'posts/delete'
  # get 'posts/new'
  resources :users do
    resources :posts
  end
  # root 'home_page#index'
  # get 'users/index'
  # get '/users', to: 'home_page#index'
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
