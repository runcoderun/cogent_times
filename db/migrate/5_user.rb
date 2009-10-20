migration 5, :create_users do
  
  up do
    create_table :users do
      column :id,           Integer, :serial => true, :nullable? => false
      column :name,         String
      column :email,        String, :nullable? => false
      column :oauth_token,  String, :nullable? => false
      column :oauth_secret, String, :nullable? => false
    end
  end
  
  down do
    drop_table :users
  end
  
end
