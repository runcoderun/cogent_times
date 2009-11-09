require 'date_extensions'

class PublicHoliday
   
  include DataMapper::Resource
  
   property :id,   Serial
   property :date, Date, :nullable => false
   property :description, String, :nullable => false, :default => ''
   
   delegate :weekend?, :weekday?, :to => :date
   
end
