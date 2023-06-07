Rails.application.routes.draw do
  resources :publications do
    resources :comments, only: [:new, :create, :show, :edit, :update, :destroy]
    resources :reactions, only: [:new, :create, :show, :edit, :update, :destroy]
  end
  
  post '/new_user_reaction', to: 'reactions#new_user_reaction', as:
  'new_user_reaction'


  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "home#index"
end
