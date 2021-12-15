# frozen_string_literal: true

def setup_test_database
  require 'pg'

  p 'Setting up test database...'

  DatabaseConnection.setup('makers_bnb_test')
  DatabaseConnection.query('TRUNCATE users;')
  DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
end

