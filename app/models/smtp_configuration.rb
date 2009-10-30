ActionMailer::Base.smtp_settings = {
  :address => "smtp.sendgrid.net",
  :port => '25',
  :domain => "cogent-times.heroku.com",
  :authentication => :plain,
  :user_name => "steve.hayes@cogentconsulting.com.au",
  :password => SystemSetting.smtp_password
}
