Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'
  get '/search', to: 'searches#search'
  get '/cooks/rank' => 'cooks#rank', as: 'rank'
  get "/cooks/timeline" => "cooks#timeline", as: 'timeline'
  delete '/notifications' => 'notifications#destroy_all'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'user/:user_id/followers' => 'relationships#followers', as: 'user_followers'
  get 'user/:user_id/followings' => 'relationships#followings', as: 'user_followings'
  devise_for :users
  resources :cooks, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :cook_comments, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :notifications, only: [:index]
end
