task :cron => :environment do
 Project.all.each {|project| project.synchronise_with_pivotal}
end
