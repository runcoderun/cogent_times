class PayrollsController < SecureController

  def index
    @people = Person.all
    @month = Month.new(date)
  end
  
  private
  
  def date
    params['date'] ? params['date'].to_date : Date.today
  end
  
end