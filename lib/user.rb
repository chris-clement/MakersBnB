# frozen_string_literal: true

require './lib/database_connection'

# User class
class User
  attr_reader :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  def self.all
    users = DatabaseConnection.query("SELECT username, password FROM users;")
    users.map do |user|
      User.new(user['username'], user['password'])
    end
  end

  def self.valid(username, password)
    result = DatabaseConnection.query("SELECT password FROM users WHERE username = $1;", [username])
    result[0]['password'] == password
  end
end
