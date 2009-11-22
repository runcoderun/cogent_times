require "dm-core"

def is_heroku?
  !!ENV['DATABASE_URL']
end

def setup_from_heroku
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end

def setup_from_config
  hash = YAML.load(File.new(File.dirname(__FILE__) + "/../database.yml"))
  DataMapper.setup(:default, hash[Rails.env].symbolize_keys)
end

is_heroku? ? setup_from_heroku : setup_from_config
