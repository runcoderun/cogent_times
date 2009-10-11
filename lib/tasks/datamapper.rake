namespace :dm do
  
  desc 'Migrate up to VERSION'
  task :migrate => :environment do
    require "migration_runner"
    Dir[File.join(Rails.root, "db", "migrate", "*")].each {|f| require f}
    migrate_up!(ENV['VERSION'])
  end
  
  desc 'Migrate down to VERSION'
  task :migrate_down => :environment do
    require "migration_runner"
    Dir[File.join(Rails.root, "db", "migrate", "*")].each {|f| require f}
    migrate_down!(ENV['VERSION'])
  end
  
end