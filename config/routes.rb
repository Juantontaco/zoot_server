Rails.application.routes.draw do

  get  '/rides' => 'rides#index'
  post '/rides/create/:special_id_code/:payment_source_id' => 'rides#create'
  post '/rides/stop/:id' => 'rides#stop'
  post '/rides/ping/:id' => 'rides#ping'
  get  '/rides/show/:id' => 'rides#show'
  post '/rides/comment/:id' => 'rides#comment'

  get 'scooters' => 'scooters#index'

  get 'scooters/:special_id_code' => 'scooters#show'


  post '/charges/add_source/:source_token' => 'charges#add_source'
  get  '/charges/sources' => 'charges#sources'

  get '/users/check_if_in_ride' => 'users#check_if_in_ride'

  mount_devise_token_auth_for 'User', at: 'auth'
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
