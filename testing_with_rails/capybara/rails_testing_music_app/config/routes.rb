Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # redirects localhost:3000 to localhost:3000/bands
  root to: redirect('/bands')
  
  resources :users, only: [:show, :new, :create]

  resource :session, only: [:new, :create, :destroy]

  resources :bands do
    # provides a route to make a new album for a given band
    resources :albums, only: [:new]
  end
  
  resources :albums, only: [:show, :create, :edit, :update, :destroy] do
    # provides a route to make a new track for a given album
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:show, :create, :edit, :update, :destroy]

  resources :notes, only: [:create, :destroy]
end
