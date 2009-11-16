migration 23, :add_project_starting_hours do
    
  up do
    modify_table :projects do
      add_column :starting_hours, Float, :nullable? => false, :default => 0.0
    end
    
  end
  
  down do
    modify_table :projects do
      drop_column :starting_hours
    end
  end
  
end
