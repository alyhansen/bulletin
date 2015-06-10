Rails.application.routes.draw do

  # Routes for the Comment resource:
  # CREATE
  post "/buildings/:building_id/posts/:post_id/create_comment", :controller => "comments", :action => "create"

  # UPDATE
  get "/buildings/:building_id/posts/:post_id/comments/:id/edit", :controller => "comments", :action => "edit"
  post "/buildings/:building_id/posts/:post_id/update_comment/:id", :controller => "comments", :action => "update"

  # DELETE
  get "/buildings/:building_id/posts/:post_id/delete_comment/:id", :controller => "comments", :action => "destroy"
  #------------------------------

  resources :buildings
  # Routes for the Building resource:
  # CREATE
  # get "/buildings/new", :controller => "buildings", :action => "new"
  post "/create_building", :controller => "buildings", :action => "create"

  # # READ
  # get "/buildings", :controller => "buildings", :action => "index"
  # get "/buildings/:id", :controller => "buildings", :action => "show"
  get "/buildings/:id/residents", :controller => "buildings", :action => "residents"
  get "/buildings/:id/pending", :controller => "buildings", :action => "pending"
  get "/buildings/:id/:filter_post", :controller => "buildings", :action => "show"

  # UPDATE
  # get "/buildings/:id/edit", :controller => "buildings", :action => "edit"
  post "/update_building/:id", :controller => "buildings", :action => "update"

  # DELETE
  # get "/delete_building/:id", :controller => "buildings", :action => "destroy"
  #------------------------------

  # Routes for the Post resource (NESTED):

  # CREATE
  post "/buildings/:building_id/create_post", :controller => "posts", :action => "create"

  # READ
  get "/buildings/:building_id/posts", :controller => "posts", :action => "index"
  get "/buildings/:building_id/posts/:id", :controller => "posts", :action => "show"

  # UPDATE
  get "/buildings/:building_id/posts/:id/edit", :controller => "posts", :action => "edit"
  post "/buildings/:building_id/update_post/:id", :controller => "posts", :action => "update"

  # DELETE
  get "/buildings/:building_id/delete_post/:id", :controller => "posts", :action => "destroy"

  #------------------------------

  # Routes for the Signup resource:
  # CREATE
  get "/signups/new", :controller => "signups", :action => "new", as: "signup_to_building"
  post "/create_signup", :controller => "signups", :action => "create"

  # READ
  get "/signups", :controller => "signups", :action => "index"
  get "/signups/:id", :controller => "signups", :action => "show"
  get "/signups/:id/approve", :controller => "signups", :action => "approve"

  # UPDATE
  get "/signups/:id/edit", :controller => "signups", :action => "edit"
  post "/update_signup/:id", :controller => "signups", :action => "update"

  # DELETE
  get "/delete_signup/:id", :controller => "signups", :action => "destroy"
  #------------------------------

  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  devise_scope :user do
     get '/users/sign_out' => 'users/sessions#destroy'
     get '/users' => 'users/registrations#index'
     get '/users/:id' => 'users/sessions#index'
     get '/users/:id/edit' => 'users/registrations#edit'
     get '/users/:id/admin_destroy' => 'users/registrations#admin_destroy'
  end

  root 'home#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
