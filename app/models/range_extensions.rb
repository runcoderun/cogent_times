module RangeExtensions
  
  def select
    result = []
    self.each do |element|
      result << element if yield(element)
    end
    return result
  end
  
end

class Range
  include RangeExtensions
end