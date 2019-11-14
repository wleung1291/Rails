Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # This one line generates eight routes (API endpoints)
  # resources :users
  #
  # get 'users', to: 'users#index', as: 'all_users'
  # get 'users/new', to: 'users#new', as: 'new_user'
  # post 'users', to: 'users#create'
  # get 'users/:id', to: 'users#show', as: 'user'
  # get 'users/:id/:edit', to: 'users#edit'
  # patch 'users/:id', to: 'users#update'
  # put 'users/:id', to: 'users#update'
  # delete 'users/:id', to: 'users#destroy'

  resources :users, only: [:index, :create, :show, :update, :destroy] do
    # nested resource to get the artwork for the given user. Can remove the 
    # index action from artworks resource since that gets all artworks
    resources :artworks, only: [:index]
  end

  # Remove the index action from the artworks resource. This will modify our 
  # API so that a user can't download all the artworks in one go, but instead 
  # only per-user. For example, you will be able to get 
  # user 1's artworks through GET /users/1/artworks
  resources :artworks, only: [:create, :show, :update, :destroy] do
    member do
      # will be dispatched to the like/unlike action of the artworks controller
      post :like, to: 'artworks#like'
      post :unlike, to: 'artworks#unlike'
    end
  end
  
  resources :comments, only: [:create, :destroy, :index] do
    # You are not limited to the routes that RESTful routing creates by default 
    # You may add additional routes that apply to the collection or individual 
    # members of the collection
    member do
      # will be dispatched to the like/unlike action of the comments controller
      post :like, to: 'comments#like'
      post :unlike, to: 'comments#unlike'
    end
  end
  
  resources :artwork_shares, only:[:create, :destroy]
end
