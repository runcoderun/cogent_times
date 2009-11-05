class OncostsController < SecureController

  resources_controller_for :oncosts

  def create
    reformat_params
    super
  end
  
  def update
    reformat_params
    super
  end
  
  private

  def reformat_params
    reformat_effective_date
    # reformat_amount
  end

  # def date
  #   return self.params['salary']['date'].to_date
  # end
  
  def reformat_effective_date
    extract_date_select_value('oncost', 'effective_date')
  end

  # def reformat_amount
  #   make_param_float('salary', 'amount')
  # end
  # 
  # def make_param_float(object, property)
  #   value = params[object][property].to_f
  #   params[object][property] = value
  # end
  
end
