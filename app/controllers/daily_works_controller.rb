class DailyWorksController < ApplicationController

  def show
    date = params['date'].to_date
    periods = WorkPeriod.all(:person_id => params['person_id'], :date => date)
    total_hours = periods.empty? ? 0 : periods.sum(&:hours)
    pp total_hours
    respond_to do |format|
      format.js   { render :text => total_hours.to_s }
    end
  end
    
end
