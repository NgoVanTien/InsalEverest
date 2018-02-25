Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper
  root "home_pages#index"

  namespace :admin do
    root "login_pages#index"
    resources :tables, only: [:index]
    resources :products, only: [:index]
  end
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :update]
      resources :sessions, only: [:create]
      resources :categories, only: [:create, :update, :destroy]
      resources :tables, only: [:index, :create, :update, :destroy]
      resources :positions, only: [:create, :update, :destroy]
      resources :products, only: [:create, :update, :destroy]
      resources :manager_tables, only: :index
      resources :orders, only: [:create, :update, :show]
      resources :pay_orders, only: :create
      resources :product_orders, only: :index
    end
  end
end
