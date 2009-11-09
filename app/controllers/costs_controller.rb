class CostsController < SecureController
  
  def index
    @people = Person.all
    oncosts = OnCostsCalculator.new(Oncost.amount_on(Date.today))
    @costs = Costs.new(Person.all, oncosts)
  end
  
end