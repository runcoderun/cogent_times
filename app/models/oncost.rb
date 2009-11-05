class Oncost
   
   include DataMapper::Resource
   
   property :id,             Serial
   property :effective_date, Date, :nullable => false
   property :amount,         Float, :nullable => false
   
   def self.on(date)
     self.all.sort_by{|each| each.effective_date}.reverse.detect {|each| each.effective_date < date}
   end

   def self.amount_on(date)
     return on(date).amount
   end
   
end
