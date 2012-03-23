Pincool::Application.routes.draw do
  root to: 'static_pages#signup'
  match "/signin/:provider/:name", to: 'static_pages#signup'
  get "/upyun_redirect", to: 'static_pages#upyun_redirect'
  
  match "/auth/:provider/callback", to: "sessions#create"
  match '/signout', to: 'sessions#destroy', via: :delete
  
  resources :users, only: [:show] do
    member do
      get "followings"
      get "found_brands"
      get "pub_posts"
      get "pub_posts_data"
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
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
