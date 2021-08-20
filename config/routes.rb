Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => 'homes#about', as: 'about'
  get '/search', to: 'search#search'
  get '/cooks/rank' => 'cooks#rank', as: 'rank'
  get "/cooks/timeline" => "cooks#timeline", as: 'timeline'
  get '/tag_search' => 'search#tag_search', as: 'tag_search'
  delete '/notifications' => 'notifications#destroy_all'
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'user/:user_id/followers' => 'relationships#followers', as: 'user_followers'
  get 'user/:user_id/followings' => 'relationships#followings', as: 'user_followings'
  get "/user/:user_id/favorites" => "users#user_favorites", as: 'user_favorites'
  devise_for :users
  resources :cooks, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :cook_comments, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :users, only: [:show, :edit, :update]
  resources :notifications, only: [:index]
end
