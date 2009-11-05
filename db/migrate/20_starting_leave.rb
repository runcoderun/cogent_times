migration 20, :add_person_starting_leave do
    
  up do
    modify_table :people do
      add_column :starting_annual_leave_hours, Float, :nullable? => false, :default => 0.0
      add_column :starting_sick_leave_hours, Float, :nullable? => false, :default => 0.0
    end
    
  end
  
  down do
    modify_table :people do
      drop_column :starting_annual_leave_hours
      drop_column :starting_sick_leave_hours
    end
  end
  
end
