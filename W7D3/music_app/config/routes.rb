Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:show, :new, :create]
  resources :bands, only: [:index, :new, :create, :edit, :show, :update, :destroy] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :show, :update, :destroy]
  
  





end
