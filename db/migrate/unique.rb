def unique(table, *columns)
  constraint_name = "unique_#{table}_#{columns.join('_')}"
  
  execute %{ALTER TABLE #{table}
            ADD CONSTRAINT #{constraint_name}
            unique(#{columns.join(',')})}
end

def drop_unique(table, *columns)
  constraint_name = "unique_#{from_table}_#{columns.join('_')}"
  
  execute %{ALTER TABLE #{table}
            DROP CONSTRAINT #{constraint_name}}
end

