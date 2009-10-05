migration 3, :create_people do
  
  up do
    create_table :people do
      column :id, Integer, :serial => true, :nullable? => false
      column :surname, String
      column :first_name, String
    end
  end
  
  down do
    drop_table :people
  end
  
end
