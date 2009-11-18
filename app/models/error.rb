class Error
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   
   property :id,       Serial
   property :text,     String, :nullable => false, :size => 255
   property :datetime, DateTime
   
end
