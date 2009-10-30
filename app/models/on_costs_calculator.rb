class OnCostsCalculator
  
  def initialize(total_costs)
    total_fte = (Person.all.collect &:fte).sum
    @cost_per_fte = total_costs/total_fte
  end
  
  def cost(fte_weight)
    return @cost_per_fte * fte_weight
  end
  
end