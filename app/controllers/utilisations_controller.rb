class UtilisationsController < BillingsController

  def select_date_range
    redirect_to utilisations_url(:start_date => selected_start_date, :end_date => selected_end_date)
  end
  
  def pie_data
    billings = Billings.new(Project.all, start_date, end_date)
    chart = Ambling::Data::Pie.new
    ProjectCategory.reportable.each do |category|
      hours = billings.timesheets_for_category(category).sum &:hours
      chart.slices << Ambling::Data::Slice.new(hours, :title => category.name)
    end
    render :xml => chart.to_xml
  end
  
end