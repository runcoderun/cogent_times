migration 29, :reduce_story_scope do
    
  up do
    modify_table :stories do
      drop_column :created_at
      drop_column :updated_at
      drop_column :completed_at
      drop_column :completed
    end
  end
  
  down do
    modify_table :stories do
      add_column :created_at, DateTime, :nullable? => false
      add_column :updated_at, DateTime, :nullable? => false
      add_column :completed, DataMapper::Types::Boolean, :nullable? => false, :default => false
      add_column :completed_at, DateTime, :nullable? => true 
    end
  end
  
end
