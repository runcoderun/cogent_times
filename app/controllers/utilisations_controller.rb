class UtilisationsController < BillingsController

  def select_date_range
    redirect_to utilisations_url(:start_date => start_date, :end_date => end_date)
  end
  
end