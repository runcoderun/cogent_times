migration 10, :create_system_setting do
    
  up do
    create_table :system_settings do
      column :id, Integer, :serial => true, :nullable? => false
      column :key, String, :nullable? => false
      column :value, String, :nullable? => true
    end
  end
  
  down do
    drop_table :system_settings
  end
  
end
