class PublicHolidaysController < SecureController

  resources_controller_for :public_holidays

  def create
    reformat_params
    super
  end
  
  # def update
  #   reformat_params
  #   super
  # end
  
  private

  def reformat_params
    reformat_date
  end

  def reformat_date
    extract_date_select_value('public_holiday', 'date')
  end

end
