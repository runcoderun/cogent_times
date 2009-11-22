task :cron => :environment do
 Project.synch_all_with_pivotal
end
