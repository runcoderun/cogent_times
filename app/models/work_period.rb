class WorkPeriod
   include DataMapper::Resource
 
   property :id,          Serial
   property :date,        Date
   property :hours,       Float
   belongs_to :person
   belongs_to :project
   
   # def person_id
   #   person.id
   # end
   # 
   # def project_id
   #   project.id
   # end
   
   # def project_id=(new_id)
   #   self.project = Project.get(new_id)
   # end
   # 
   # def person_id=(new_id)
   #   self.person = Person.get(new_id)
   # end

end
