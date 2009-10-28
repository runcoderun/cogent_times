class SalariesController < SecureController
  # resources_controller_for :stories
  resources_controller_for :salaries, :in => :person

  def create
    require 'pp'
    pp params
    reformat_params
    pp params
    super
  end
  
  def update
    reformat_params
    super
  end
  
  private

  def reformat_params
    reformat_start_date
    reformat_amount
    reformat_person
  end

  def person_id
    return self.params['salary']['person_id'].to_i
  end
  
  def reformat_person
    self.params['salary']['person'] = Person.get(person_id)
  end
  
  def date
    return self.params['salary']['date'].to_date
  end
  
  def reformat_start_date
    extract_date_select_value('salary', 'start_date')
  end

  def reformat_amount
    make_param_float('salary', 'amount')
  end
  
  def make_param_float(object, property)
    value = params[object][property].to_f
    params[object][property] = value
  end
  
end
