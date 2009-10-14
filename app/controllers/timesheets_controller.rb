class TimesheetsController < ApplicationController
  
  # probably need to restructure this so that id is the person id
  
  # def index
  # end
  
  def edit
    person = Person.get(params['person']['id'])
    start_date = Date.today
    @timesheet = Timesheet.new(person, start_date)
  end
   
  # def update
  #   respond_to do |format|
  #     format.html {puts 'Responding to HTML'}
  #     format.js   { render :text => 'Rex' }
  #   end
  # end
   
end
