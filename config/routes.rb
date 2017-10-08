Rails.application.routes.draw do
  	
  post 'friendships/create'
  get 'friendships/create'
  delete 'friendships/destroy' => 'friendships#destroy'
  get 'friendships/destroy'
  post 'friendships/accept'
	post 'likes/toggle_comment_like/' => 'likes#toggle_comment_like'
	post 'likes/toggle_post_like/' => 'likes#toggle_post_like'

  get 'comments/create'

  get 'comments/destroy'

  devise_for :users
  get 'users/filter_by_email' => 'users#filter_by_email'
  get 'users/:id' => 'users#show', as: :user_show
  get 'user/:id' => 'users#show'
  patch 'user/:id' => 'users#update', as: :user
  resources :posts, only: [:index, :create, :destroy]
  resources :comments, only: [:create, :destroy]

  root "posts#index"
end
