class User
   include DataMapper::Resource
 
   property :id,           Serial
   property :name,         String, :nullable => false
   property :email,        String, :nullable => false
   property :oauth_token,  String, :nullable => false
   property :oauth_secret, String, :nullable => false
   
   # validates_uniqueness_of :email
   
end
