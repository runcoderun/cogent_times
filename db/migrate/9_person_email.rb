migration 9, :add_person_email do
    
  up do
    modify_table :people do
      add_column :email, String, :nullable? => true
    end
    
  end
  
  down do
    modify_table :people do
      drop_column :email
    end
  end
  
end
