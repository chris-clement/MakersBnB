require 'pg'
require './lib/database_connection'

  if ENV['ENVIRONMENT'] == 'test'
    DatabaseConnection.setup('makers_bnb_test')
    
  else
    DatabaseConnection.setup('makers_bnb')
  end
  # DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")