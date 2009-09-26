require 'dm-migrations/migration_runner'

migration 1, :create_employees do
  
  up do
    create_table :employees do
      column :id, Integer, :serial => true, :nullable? => false
      column :surname, String
      column :first_name, String
    end
  end
  
  down do
    drop_table :employees
  end
  
end
