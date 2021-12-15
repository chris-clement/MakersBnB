# frozen_string_literal: true

require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('makers_bnb_test')
  DatabaseConnection.query("ALTER SEQUENCE users_id_seq RESTART WITH 1;")
else
  DatabaseConnection.setup('makers_bnb')
end
