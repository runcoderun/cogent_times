migration 24, :add_pivotal_ids do
    
  up do
    modify_table :projects do
      add_column :pivotal_id, Integer, :nullable? => true
    end
    modify_table :stories do
      add_column :pivotal_id, Integer, :nullable? => true
    end
  end
  
  down do
    modify_table :projects do
      drop_column :pivotal_id
    end
    modify_table :stories do
      drop_column :pivotal_id
    end
  end
  
end
