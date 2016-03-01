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

resources :messages, only: [:new, :create]

resources :posts
resources :comments



resources :relationships,       only: [:create, :destroy]

resources :users do
 member do 
  get :following, :followers
 end
end      
delete 'posts/comments/:id' => 'posts#comment_destroy', as: 'comment_delete_place'
 
root 'users#index'
  
end
