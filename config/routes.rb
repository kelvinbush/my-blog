Rails.application.routes.draw do
  get 'likes/create'
  get 'comment/new'
  get 'comment/create'
  root to: 'users#index'
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:index, :create]
      resources :likes, only: [:create]
    end
  end

end
