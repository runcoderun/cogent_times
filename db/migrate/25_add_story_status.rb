require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 25, :add_story_status do
    
  up do
    create_table :story_statuses do
      column :id, Integer, :serial => true, :nullable? => false
      column :atom_id, String, :nullable? => true
      column :story_id, Integer, :nullable? => false
      column :datetime, DateTime
      column :status, String
      column :person_name, String
    end
    foreign_key(:story_statuses, :story_id, :stories)
  end
  
  down do
    drop_foreign_key(:story_statuses, :story_id, :stories)
    drop_table :story_statuses
  end
  
end
