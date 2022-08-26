Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:index, :create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
  get 'users/:user_id/posts_list', to: 'api#list_posts', as: :list_posts
  get 'users/:user_id/posts/:post_id/comments_list', to: 'api#list_comments', as: :list_comments
  post 'users/:user_id/posts/:post_id/comment_create', to: 'api#create_comment', as: :create_comment
end
