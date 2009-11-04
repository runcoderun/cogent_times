migration 16, :add_project_category do
    
  up do
    create_table :project_categories do
      column :id, Integer, :serial => true, :nullable? => false
      column :name, String, :nullable? => false
      column :use_in_reports, DataMapper::Types::Boolean, :nullable? => false, :default => true
    end
    default = ProjectCategory.new(:name => 'Non-reportable')
    default.save
    modify_table :projects do
      add_column :project_category_id, Integer, :nullable? => false, :default => default.id
    end
    foreign_key(:projects, :project_category_id, :project_categories)
  end
  
  down do
    drop_foreign_key(:projects, :project_category_id, :project_categories)
    modify_table :projects do
      drop_column :project_category_id
    end
    drop_table :project_categories
  end
  
  
end
