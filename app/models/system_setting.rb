class SystemSetting
  
  include DataMapper::Resource
  
  property :id,    Serial
  property :key,   String, :nullable => false
  property :value, String, :nullable => true
  
  def self.smtp_password
    SystemSetting.first(:key => 'smtp_password').value  
  end 
  
  def self.smtp_password=(new_value)
    setting = SystemSetting.first(:key => 'smtp_password') || SystemSetting.new(:key => 'smtp_password')
    setting.value = new_value
    setting.save
  end
  
end
