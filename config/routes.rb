# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :home

  authenticated do
    root 'home#about'
  end

  unauthenticated do
    root 'home#index'
  end
end
