migration 8, :add_story_completed do
    
  up do
    modify_table :stories do
      add_column :completed, DataMapper::Types::Boolean, :nullable? => false, :default => false
      add_column :completed_at, DateTime, :nullable? => true 
    end
    
  end
  
  down do
    modify_table :stories do
      drop_column :completed
      drop_column :completed_at
    end
  end
  
end
