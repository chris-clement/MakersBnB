# frozen_string_literal: true

require './lib/database_connection'

# User class
class User
  
  def self.valid(username, password)
    result = DatabaseConnection.query("SELECT password FROM users WHERE username = $1;", [username])
    result[0]['password'] == password
  end

  def self.user_id(username:)
    id = (DatabaseConnection.query("SELECT id FROM users WHERE username = $1;", [username])).to_a[0]["id"].to_i
  end
end
