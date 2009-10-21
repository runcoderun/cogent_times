require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 7, :create_story do
    
  up do
    create_table :stories do
      column :id, Integer, :serial => true, :nullable? => false
      column :name, String, :nullable? => false, :default => 'unnamed'
      column :project_id, Integer, :nullable? => false
      column :created_at, DateTime, :nullable? => false
      column :updated_at, DateTime, :nullable? => false
    end
    foreign_key(:stories, :project_id, :projects)
  end
  
  down do
    drop_foreign_key(:stories, :project_id, :projects)
    drop_table :stories
  end
  
end
