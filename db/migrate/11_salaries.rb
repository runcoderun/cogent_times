require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 11, :create_salaries do
    
  up do
    create_table :salaries do
      column :id, Integer, :serial => true, :nullable? => false
      column :person_id, Integer, :nullable? => false
      column :start_date, Date
      column :amount, Float
    end
    foreign_key(:salaries, :person_id, :people)
  end
  
  down do
    drop_foreign_key(:salaries, :person_id, :people)
    drop_table :salaries
  end
  
end
