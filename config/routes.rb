Rails.application.routes.draw do
  devise_for :users 
  

resources :conversations, only: [:index, :show, :destroy] do
 member do
  post :reply
  post :restore
  post :mark_as_read
  end
 collection do
 delete :empty_trash
 end
end

resources :posts do
resources :comments 
end

resources :posts,               only: [:create, :destroy]
resources :relationships,       only: [:create, :destroy]
resources :messages, only: [:new, :create]
  
resources :users do
 member do 
  get :following, :followers
 end
end      

  
root 'users#index'
  
end
