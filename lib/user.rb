# frozen_string_literal: true

require './lib/database_connection'

# User class
class User
  
  def self.valid(username, password)
    result = DatabaseConnection.query("SELECT password FROM users WHERE username = $1;", [username])
    if result.count.zero?
      false
    else
      result[0]['password'] == password
    end
  end


  def self.user_id(username:)
    id = (DatabaseConnection.query("SELECT id FROM users WHERE username = $1;", [username])).to_a[0]["id"].to_i
  end

    
  def self.create_user(username, password, email, phone_number)
    DatabaseConnection.query("INSERT INTO users(username, password, email, phone_number) VALUES ($1, $2, $3, $4) RETURNING(username, password, email, phone_number);", [username, password, email, phone_number])
    result = DatabaseConnection.query("SELECT * FROM users;")
  end

  def self.unique_username(username)
    result = DatabaseConnection.query("SELECT username FROM users WHERE username = $1;", [username])
    if result.count.zero?
      true
    else
      false
    end
  end
end
