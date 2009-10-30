class CostsController < SecureController
  
  def index
    @people = Person.all
  end
  
end