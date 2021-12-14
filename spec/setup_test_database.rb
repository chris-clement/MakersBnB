# frozen_string_literal: true

require 'pg'

def setup_test_database
  p 'Setting up test database...'

  DatabaseConnection.setup('makers_bnb_test')
  DatabaseConnection.query('TRUNCATE users CASCADE;')
  # DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
end
