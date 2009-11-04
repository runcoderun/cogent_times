class ProjectCategory
  
  include DataMapper::Resource
  include DataMapper::Constraints
  
  property :id,             Serial
  property :name,           String, :nullable => false
  property :use_in_reports, Boolean, :nullable => false, :default => true
   
  has n, :projects, :constraint => :protect # this is broken - need to find right constraint from internet
     
  def self.reportable
    return self.all(:use_in_reports => true)
  end
     
end
