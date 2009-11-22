migration 31, :rename_story_status_status do
    
  up do
    modify_table :story_statuses do
      rename_column :status, :status_text
    end
    
  end
  
  down do
    modify_table :story_statuses do
      drop_column :status_text, :status
    end
  end
  
end
