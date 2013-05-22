MobileMoneyEcosystem::Application.routes.draw do

  get '/market/:merchant_name' => 'markets#show', :as => :market
  get '/history' => 'histories#index', :as => :history
  get '/statistics/:kind' => 'statistics#index', :as => :statistics

  match "api/products/:id" => "api/products#show"
  match "api/cart/:id" => "api/cart#show"

  devise_scope :user do
    get "/register/merchant" => "registrations#new_merchant", :as => :merchant_registration
    get "/register/client" => "registrations#new", :as => :client_registration
    get "/register" => "registrations#selection", :as => :selection_registration
    match "/register/merchant" => "registrations#create", :as => :register_merchant, :via => :post
    match "/register/client" => "registrations#create", :as => :register_client, :via => :post
    post 'registrations' => 'registrations#create', :as => 'register'
    post 'sessions' => 'sessions#create', :as => 'login'
    delete 'sessions' => 'sessions#destroy', :as => 'logout'
  end


  get "api/cart/allcarts"
  get "home/index"
  get "header_info" => "users#header_info", :as => :credit_client
  get "/credits" => "credits#index", :as => :credits
  match "/credits" => "credits#update", :as => :credits, :via => :post

  devise_for :users, :path => '', :controllers => {:registrations => "registrations"},
             :path_names => { :sign_in => 'login',
                              :sign_up => 'register',
                              :sign_out => 'logout'}

  resources :limits
  resources :settings
  resources :products
  resources :users
  resources :merchants
  resources :clients


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
   root :to => 'home#index'


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
