class Error
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   include DataMapper::ValidateAndSave
   
   property :id,       Serial
   property :text,     String, :nullable => false, :size => 255
   property :datetime, DateTime
   
   def self.record(text)
     error = Error.new(:text => text, :datetime => Time.now)
     error.validate_and_save
   end
     
end
