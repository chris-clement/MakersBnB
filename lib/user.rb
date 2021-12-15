# frozen_string_literal: true

require './lib/database_connection'

# User class
class User
  
  def self.valid(username, password)
    result = DatabaseConnection.query("SELECT password FROM users WHERE username = $1;", [username])
    result[0]['password'] == password
  end
end
