Rails.application.routes.draw do
      
#Routes
    post 'houses/edit_multiple'
    put 'houses/update_multiple'
    get 'houses/show_multiple'
    get "houses/viewall"
    get "houses/searchresults"
    get "houses/search"
    get "houses/pdfconverter"
    get "houses/:id/salesandlistings", to: "mixed#salesandlistings", as: "houses_salesandlistings"
  resources :housefiles  
  resources :houses do
    resources :listings
    resources :sales
    resources :housefiles
    get'statusupdate', on: :member
    get'addattach', on: :member
    get'editattach', on: :member
    post :pdfupload, :on => :collection
  end
root to: 'houses#index'
  resources :agents
   resources :sales do 
         resources :agents
   get'agentadd', on: :member
    end
   resources :listings do
     resources :agents
    get'agentadd', on: :member
   end
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
