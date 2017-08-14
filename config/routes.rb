Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/index'
  root 'home#index'

  get 'login', to: 'sessions#login'

  get 'users/profile'
  get '/users/:id/mypictures', to: 'users#mypictures'

  get 'pictures/new'

  resources :users do
    resources :pictures do
      resources :comments
      resources :votes
    end
  end
  resources :sessions
end
