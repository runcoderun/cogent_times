migration 6, :add_dev_user do
  
  up do
    User.new(:email => 'dummy@dummy.com', :name => 'Development', :oauth_token => 'dummy', :oauth_secret => 'dummy').save
  end
  
  down do
    User.first(:name => 'Development').destroy
  end
  
end
