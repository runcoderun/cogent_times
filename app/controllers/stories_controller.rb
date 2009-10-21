class StoriesController < SecureController
  # resources_controller_for :stories
  resources_controller_for :stories, :in => :project
end
