class TimesheetsController < ApplicationController
  
  def index
  end
  
  def edit
    require 'pp'
    pp params
    @person = Person.get(params['person']['id'])
    @start_date = Date.today
    @timesheet = Timesheet.new(@person, @start_date)
  end
    
end
