def project_routes(map)
  map.resources :project_categories
  map.resources :projects do |project|
    project.resource :project_dashboard, :member => {:select => :post}
    project.resources :stories, :collection => {:synchronise => :put ,:activity => :put} do |story|
      story.resources :story_statuses
    end
    project.resources :status_changes
    project.resources :expenses
  end
  map.resources :project_costs
end

def root_route(map)
  map.root :controller => "session"
end

def default_routes(map)
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

ActionController::Routing::Routes.draw do |map|


  map.resources :timesheets, :member => { :project_total => :get, :date_total => :get, :total => :get } 
  map.resources :billings
  map.resources :utilisations, :collection => {:select_date_range => :post}
  map.resources :timesheet_checks, :member => { :reminder => :post }
  map.resources :costs
  
  # move these to a namespace
  project_routes(map)

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
  map.resources :errors

  map.resources :home
  map.resources :session, :collection => { :create => :get, :delete => :get }

  root_route(map)
  default_routes(map)

end
