class UtilisationsController < BillingsController

  def select_date_range
    redirect_to utilisations_url(:start_date => selected_start_date, :end_date => selected_end_date)
  end
  
end