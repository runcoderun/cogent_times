migration 15, :add_project_rate do
    
  up do
    modify_table :projects do
      add_column :use_fixed_daily_rate, DataMapper::Types::Boolean, :nullable? => false, :default => false
      add_column :fixed_daily_rate, Float
    end
    
  end
  
  down do
    modify_table :projects do
      drop_column :use_fixed_daily_rate
      drop_column :fixed_daily_rate
    end
  end
  
end
