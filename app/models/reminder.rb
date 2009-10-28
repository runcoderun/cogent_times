class Reminder < ActionMailer::Base

  def missing_hours(recipient)
    recipients recipient.email
    from       "info@cogentconsulting.com.au"
    subject    "Missing Hours"
    body       :person => recipient
  end  

end

# Notifier.deliver_missing_hours(david) # sends the email
