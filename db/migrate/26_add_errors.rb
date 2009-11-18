require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 26, :add_errors do
    
  up do
    create_table :errors do
      column :id, Integer, :serial => true, :nullable? => false
      column :datetime, DateTime
      column :text, String, :size => 255
    end
  end
  
  down do
    drop_table :errors
  end
  
end
