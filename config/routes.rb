Rails.application.routes.draw do
  resources :labels, only: [:new, :create, :edit, :update, :destroy]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :tasks
  root to: 'tasks#index'
end
