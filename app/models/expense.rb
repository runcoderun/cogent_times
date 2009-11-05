class Expense
   
   include DataMapper::Resource
   include DataMapper::ActiveRecordAdapter
   
   property :id,     Serial
   property :date,   Date
   property :amount, Float
   property :notes,  Text
   
   belongs_to :project
   
   validates_present :project

end
