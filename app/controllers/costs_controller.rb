class CostsController < SecureController
  
  def index
    @people = Person.all
    @oncosts = OnCostsCalculator.new(120000.00)
  end
  
end