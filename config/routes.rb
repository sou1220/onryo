Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
      sessions: 'admin/sessions'
  }
  
  namespace :admin do
      get 'dashboards', to: 'dashboards#index'
      resources :users, only: [:destroy]
      resources :reviews, only: [:destroy]
  end
  
  devise_for :users
  resources :users, only: [:edit, :show, :update] 
   get 'users/:id/destroy', to: 'users#destroy', as: 'destroy_user'
   delete 'users/:id/destroy', to: 'users#destroy'
   
   devise_scope :user do
     post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
   end
  
  get 'mypage' => 'users#mypage'
  
  resources :posts do
      resources :comments, only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
  end
    
  root to: 'homes#top'
  get "/search" => "searches#search"
  get "/tag_search" => "tags#tag_search"
  
end
