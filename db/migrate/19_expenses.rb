require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 19, :create_expenses do
    
  up do
    create_table :expenses do
      column :id, Integer, :serial => true, :nullable? => false
      column :date, Date, :nullable? => false
      column :amount, Float, :nullable? => false, :default => 0.0
      column :notes, DataMapper::Types::Text, :nullable? => false, :default => ''
      column :project_id, Integer, :nullable? => false
    end
    foreign_key(:expenses, :project_id, :projects)
  end
  
  down do
    drop_foreign_key(:expenses, :project_id, :projects)
    drop_table :expenses
  end
  
end
