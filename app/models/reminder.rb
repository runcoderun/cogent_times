require 'smtp_configuration'

class Reminder < ActionMailer::Base

  def missing_hours(recipient)
    recipients recipient.email
    from       "info@cogentconsulting.com.au"
    subject    "Missing Hours"
    body       :person => recipient
  end  

end

# steve = People.find(3)
# Reminder.deliver_missing_hours(steve)
