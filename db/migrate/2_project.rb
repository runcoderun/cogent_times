migration 2, :create_projects do
  
  up do
    create_table :projects do
      column :id, Integer, :serial => true, :nullable? => false
      column :name, String
    end
  end
  
  down do
    drop_table :projects
  end
  
end
