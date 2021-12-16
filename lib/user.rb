# frozen_string_literal: true

require './lib/database_connection'

# User class
class User
  
  def self.valid(username, password)
    result = DatabaseConnection.query("SELECT password FROM users WHERE username = $1;", [username])
    result[0]['password'] == password
  end

  def self.create_user(username, password, email, phone_number)
    DatabaseConnection.query("INSERT INTO users(username, password, email, phone_number) VALUES ($1, $2, $3, $4) RETURNING(username, password, email, phone_number);", [username, password, email, phone_number])
    result = DatabaseConnection.query("SELECT * FROM users;")
  end
end
