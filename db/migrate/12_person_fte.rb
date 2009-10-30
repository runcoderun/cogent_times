migration 12, :add_person_fte do
    
  up do
    modify_table :people do
      add_column :fte, Float, :nullable? => false, :default => 1.0
    end
    
  end
  
  down do
    modify_table :people do
      drop_column :fte
    end
  end
  
end
