# Secret for session cookie signature.
# origin: GM

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_platforms_session',
  :secret      => 'UEUO6F-2rGvY~^W#1*8v)4+MV8Y`IYwzJ@ghAkVn?7Z9fz1#-2xwLGni9Pu%Os/Vxm>Nc+{&jU!9\[ARM!W+0owU7q@n$v<hqT1.|-Y,sF.?!AwI~7q[hngM<mLsnVN2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
