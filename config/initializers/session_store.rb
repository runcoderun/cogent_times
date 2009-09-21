# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cogent_times_session',
  :secret      => '70356c0cad3ac8195577cc48e20505adfdb7556ff595a9437651249fd20ae971fe60f1cd0a428e178bc9c7ba5bea6c682b90cc475d246ce6a2c48ece735598a9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
