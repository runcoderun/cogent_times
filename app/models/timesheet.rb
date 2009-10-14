class Timesheet
  
  attr_reader :start_date
  
  def initialize(person, start_date)
    @person = person
    @start_date = start_date
  end
  
  def person_name
    @person.full_name
  end
  
  def person_id
    @person.id
  end
  
  def date_range
    return start_date..(6.days.from_now(start_date))
  end
  
  def work(project, date)
    return 0
  end
  
  def date_total(date)
    return 0
  end
  
  def total
    return 0
  end
  
  def project_total(project)
    return 0
  end
  
end