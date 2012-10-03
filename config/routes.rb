SMproto::Application.routes.draw do

  get "teoriat/tavoitteet"

  get "teoriat/kannusteet"

  get "teoriat/kilpailut"

  get "teoriat/palaute"

  get "teoriat/yleista"

 resources :bonuslevels
 resources :goals
 resources :competitions
 resources :categories
 resources :products
 resources :users
 resources :salegroups
 resources :contacts
 resources :sessions, only: [:new, :create, :destroy]
  root :to => 'sessions#new'
 # get "pages/esimies_main"

  
  match '/esimies_main', to: 'pages#esimies_main'
  match '/myyja_main', to: 'pages#myyja_main'
  match '/kokonaismyynti', to: 'pages#kokonaismyynti'
  match '/myyntiryhmat', to: 'pages#myyntiryhmat'
  match '/kilpailut', to: 'pages#kilpailut'
  match '/tuotehallinta', to: 'categories#tuotehallinta'
  match '/myyjahallinta', to: 'salegroups#myyjahallinta'
  match '/signout', to: 'sessions#destroy', via: :delete
  match '/users_index', to: 'users#index'
  match '/ryhmavaihto', to: 'myyntiryhmat#ryhmavaihto', via: :post
  match '/aikavaihto', to: 'myyntiryhmat#aikavaihto', via: :post
  match '/myyjavaihto', to: 'myyntiryhmat#myyjavaihto', via: :post
  match '/contact_ryhmavaihto', to: 'contacts#contact_ryhmavaihto', via: :post
  match '/contact_myyjavaihto', to: 'contacts#contact_myyjavaihto', via: :post
  match '/contact_aikavaihto', to: 'contacts#contact_aikavaihto', via: :post
  match '/kontaktit', to: "contacts#index"
  match '/competitions_new', to: "competitions#new"
  match '/competitions', to: "competitions#index"
  match '/kilpailuvaihto', to: "competitions#kilpailuvaihto"
  match '/kilpailuvaihto_myyja', to: "pages#kilpailuvaihto"
  match '/tavoite_myyjavaihto', to: "goals#tavoite_myyjavaihto"
  match '/bonus_ryhmavaihto', to: "bonuslevels#bonus_ryhmavaihto"
 # match '/bonuslevels', to: "bonuslevel#create"
  #match '/bonuslevel/new', to: "bonuslevel#new"
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
