require "dm-core"
if ENV['DATABASE_URL']
  DataMapper.setup(:default, ENV['DATABASE_URL'])
else
  hash = YAML.load(File.new(Rails.root + "/config/database.yml"))
  DataMapper.setup(:default, hash[Rails.env])
end
