module DateRangeSelection

  def selected_start_date
    params['start_date'] ? extract_select_date_value('start_date') : default_start_date
  end
  
  def selected_end_date
    params['end_date'] ? extract_select_date_value('end_date') : default_end_date
  end
  
  def start_date
    params['start_date'] ? params['start_date'].to_date : default_start_date
  end

  def end_date
    params['end_date'] ? params['end_date'].to_date : default_end_date
  end
  
  def default_start_date
    Date.today.start_of_month
  end
  
  def default_end_date
    Date.today.end_of_month
  end
  
end