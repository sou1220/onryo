Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:edit, :show, :update] 
   get 'users/:id/destroy', to: 'users#destroy', as: 'destroy_user'
   delete 'users/:id/destroy', to: 'users#destroy'
  
  get 'mypage' => 'users#mypage'
  resources :posts
  root to: 'homes#top'
end
