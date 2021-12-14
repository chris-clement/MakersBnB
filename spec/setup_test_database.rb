require 'pg'

def setup_test_database
  p "Setting up test database..."

  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec('TRUNCATE users CASCADE;')
  # Not how it's meant to be done - when merging, please keep original DatabaseConnection!
end