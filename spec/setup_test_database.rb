require 'pg'
require 'database_connection'

def setup_test_database
  p "Setting up test database..."

  DatabaseConnection.setup('makers_bnb_test')
  DatabaseConnection.query('TRUNCATE users, spaces, bookings CASCADE;')
  # DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
end