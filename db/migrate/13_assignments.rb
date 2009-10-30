require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 13, :create_assignments do
    
  up do
    create_table :assignments do
      column :id, Integer, :serial => true, :nullable? => false
      column :person_id, Integer, :nullable? => false
      column :rate, Float
      column :project_id, Integer, :nullable? => false
    end
    foreign_key(:assignments, :person_id, :people)
    foreign_key(:assignments, :project_id, :projects)
  end
  
  down do
    drop_foreign_key(:assignments, :person_id, :people)
    drop_foreign_key(:assignments, :project_id, :projects)
    drop_table :assignments
  end
  
end
