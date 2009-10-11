def foreign_key(from_table, from_column, to_table)
  constraint_name = "fk_#{from_table}_#{from_column}"
  
  execute %{ALTER TABLE #{from_table}
            ADD CONSTRAINT #{constraint_name}
            FOREIGN KEY (#{from_column})
            REFERENCES #{to_table}(id)
            ON DELETE CASCADE}
end

def drop_foreign_key(from_table, from_column, to_table)
  constraint_name = "fk_#{from_table}_#{from_column}"
  
  execute %{ALTER TABLE #{from_table}
            DROP CONSTRAINT #{constraint_name}}
end

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
