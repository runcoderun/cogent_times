migration 28, :make_story_name_longer do
    
  up do
    modify_table :stories do
      change_column :name, 'varchar(250)'
    end
  end
  
  down do
    modify_table :stories do
      change_column :name, 'varchar(50)'
    end
  end
  
end
