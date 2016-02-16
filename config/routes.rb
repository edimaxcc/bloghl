Rails.application.routes.draw do
  devise_for :users 
  


resources :posts do
resources :comments, only: [:create] 
end

resources :posts,               only: [:create, :destroy]
resources :relationships,       only: [:create, :destroy]

  
resources :users do
 member do 
  get :following, :followers
 end
end      

  
root 'users#index'
  
end
