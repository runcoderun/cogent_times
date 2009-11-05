migration 18, :create_oncosts do
    
  up do
    create_table :oncosts do
      column :id, Integer, :serial => true, :nullable? => false
      column :effective_date, Date
      column :amount, Float
    end
  end
  
  down do
    drop_table :oncosts
  end
  
end
