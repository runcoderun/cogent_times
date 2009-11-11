migration 22, :add_work_period_descriptions do
    
  up do
    modify_table :work_periods do
      add_column :description, String, :nullable? => false, :default => ''
    end
    
  end
  
  down do
    modify_table :work_periods do
      drop_column :description
    end
  end
  
end
