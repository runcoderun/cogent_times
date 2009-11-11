ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  map.resources :timesheets, :member => { :project_total => :get, :date_total => :get, :total => :get } 
  map.resources :billings
  map.resources :utilisations, :collection => {:select_date_range => :post}
  map.resources :timesheet_checks, :member => { :reminder => :post }
  map.resources :costs
  
  # move these to a namespace
  map.resources :project_categories
  map.resources :projects do |project|
    project.resources :stories
    project.resources :expenses
  end
  map.resources :people do |person|
    person.resources :salaries
  end
  map.resources :work_periods, :collection => {:cleanup => :post, :select => :post}
  map.resources :oncosts
  map.resources :assignments
  map.resources :system_settings
  map.resources :users
  map.resources :public_holidays
  map.resources :payrolls

  map.resources :home
  map.resources :session, :collection => { :create => :get, :delete => :get }
  
  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "session"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
