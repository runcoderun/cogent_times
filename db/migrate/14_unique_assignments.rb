require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 14, :unique_assigments do
    
  up do
    unique(:assignments, :person_id, :project_id)
  end
  
  down do
    drop_unique(:assignments, :person_id, :project_id)
  end
  
end
