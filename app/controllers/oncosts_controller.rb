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
  end

  def reformat_effective_date
    extract_date_select_value('oncost', 'effective_date')
  end

end
