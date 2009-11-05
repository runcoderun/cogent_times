migration 17, :add_project_starting_cost do
    
  up do
    modify_table :projects do
      add_column :starting_cost, Float, :nullable? => false, :default => 0.0
    end
    
  end
  
  down do
    modify_table :projects do
      drop_column :starting_cost
    end
  end
  
end
