class SystemSetting
  
  include DataMapper::Resource
  
  property :id,    Serial
  property :key,   String, :nullable => false
  property :value, String, :nullable => true
   
end
