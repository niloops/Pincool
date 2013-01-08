Pincool::Application.routes.draw do
  devise_for :users

  root to: 'static_pages#signup'
  get "/upyun_redirect", to: 'static_pages#upyun_redirect'

  resources :users, only: [:show] do
    member do
      get "followings"
      get "found_brands"
      get "pub_posts"
      get "pub_posts_data"
      get "messages"
      get "messages_data"
      post "messages_readall"
    end
  end

  match "/home", to: "users#home"
  match "/follow_posts_data", to: "users#follow_posts_data",
  as: "follow_posts_data"

  resources :brands do
    member do
      post "follow_toggle"
      get "posts_data"
    end
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end
  get "explore", to: "posts#index"
  get "explore_data", to: "posts#index_data"

  resources :invited_users, only: [:new, :create, :index, :destroy]

  resources :categories do
    collection do
      get "index_for_admin"
    end
  end

  resources :eva_names, only: [:new, :create, :index, :destroy]

end
