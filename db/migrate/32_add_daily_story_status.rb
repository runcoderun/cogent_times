require File.expand_path(File.dirname(__FILE__) + '/foreign_keys')

migration 32, :add_daily_story_status do
    
  up do
    # create_table :statuses do
    #   column :id, Integer, :serial => true, :nullable? => false
    #   column :description, String
    # end
    # 
    # create_table :daily_story_statuses do
    #   column :id, Integer, :serial => true, :nullable? => false
    #   column :story_id, Integer, :nullable? => false
    #   column :date, Date, :nullable? => false
    #   column :status_id, Integer, :nullable? => false
    # end
    # 
    # modify_table :story_statuses do
    #   add_column :status_id, Integer
    # end
    # 
    # foreign_key(:daily_story_statuses, :story_id, :stories)
    # foreign_key(:daily_story_statuses, :status_id, :statuses)
    # foreign_key(:story_statuses, :status_id, :statuses)
    
    StoryStatus.all.each do |story_status|
      text = story_status.status_text
      if !text.blank?
        status = Status.first(:description => text)
        if !status
          status = Status.new(:description => text)
          status.validate_and_save
        end
        story_status.status_id = status.id
        story_status.validate_and_save
      end
    end
      
  end
  
  down do
    
    # StoryStatus.all.each do |story_status|
    #   story_status.status_text = story_status.status.description
    #   story_status.validate_and_save
    # end
    
    drop_foreign_key(:story_statuses, :status_id, :statuses)
    drop_foreign_key(:daily_story_statuses, :status_id, :statuses)
    drop_foreign_key(:daily_story_statuses, :story_id, :stories)

    modify_table :story_statuses do
      drop_column :status_id
    end
    
    drop_table :daily_story_statuses
    drop_table :statuses
  end
  
end
