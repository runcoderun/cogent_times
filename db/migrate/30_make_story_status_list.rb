migration 30, :make_story_status_list do
    
  up do
    modify_table :story_statuses do
      add_column :position, Integer, :nullable? => false, :default => 0
    end
    StoryStatus.all {|status| status.position = 0; status.save}
    Story.all.each {|story| StoryStatus.repair_list(:story_id => story.id)}
  end
  
  down do
    modify_table :story_statuses do
      drop_column :position
    end
  end
  
end
