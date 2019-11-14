Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :users

  # The session resource is singular because the user will only use at most one 
  # session: their own.
  resource :session
end
