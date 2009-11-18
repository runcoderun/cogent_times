migration 27, :add_activity_feed_id do
    
  up do
    modify_table :projects do
      add_column :pivotal_activity_feed_id, String, :nullable? => true
    end
  end
  
  down do
    modify_table :projects do
      drop_column :pivotal_activity_feed_id
    end
  end
  
end
