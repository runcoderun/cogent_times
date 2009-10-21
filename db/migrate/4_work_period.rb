require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 4, :create_work_period do
    
  up do
    create_table :work_periods do
      column :id, Integer, :serial => true, :nullable? => false
      column :person_id, Integer, :nullable? => false
      column :date, Date
      column :hours, Float
      column :project_id, Integer, :nullable? => false
    end
    foreign_key(:work_periods, :person_id, :people)
    foreign_key(:work_periods, :project_id, :projects)
  end
  
  down do
    drop_foreign_key(:work_periods, :person_id, :people)
    drop_foreign_key(:work_periods, :project_id, :projects)
    drop_table :work_periods
  end
  
end
