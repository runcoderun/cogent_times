migration 21, :create_public_holidays do
    
  up do
    create_table :public_holidays do
      column :id, Integer, :serial => true, :nullable? => false
      column :date, Date, :nullable? => false
      column :description, String, :nullable? => false, :default => ''
    end
  end
  
  down do
    drop_table :public_holidays
  end
  
end
