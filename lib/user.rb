require './lib/database_connection'

class User
  attr_reader :username, :password

  def initialize(username, password)
    @username = username
    @password = password
  end

  def self.valid(username, password)
    result = User.all.map{ |user| user.username == username && user.password == password}
    result.include?(true)
  end

  def self.all
    usertest = DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    users = DatabaseConnection.query("SELECT username, password FROM users;")
    users.map do |user|
      User.new(user["username"], user["password"])
    end
  end
end