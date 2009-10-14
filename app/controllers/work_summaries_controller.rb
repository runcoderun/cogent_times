class WorkSummariesController < ApplicationController

  def show
    require 'pp'
    pp params
    start_date = params['start_date'].to_date
    end_date = params['end_date'].to_date
    date_range = start_date..end_date
    # change this to be a date range
    periods = WorkPeriod.all(:project_id => params['project_id'], :person_id => params['id']).select {|work| date_range.include?(work.date)}
    total_hours = periods.empty? ? 0 : periods.sum(&:hours)
    pp total_hours
    respond_to do |format|
      format.js   { render :text => total_hours.to_s }
    end
  end
  
  def update
    # require 'pp'
    # pp params
    date = params['date'].to_date
    key = { :project_id => params['project_id'], :person_id => params['id'], :date => date }
    period = WorkPeriod.first(key) || WorkPeriod.new(key)
    period.hours = params['hours'].to_f
    period.save
  end
  
end
