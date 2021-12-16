require 'pg'
require './lib/database_connection'

class Updater

  def self.list(id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE user_id = $1;", [id])

    result.map do |spaces|
      p spaces['name']
    end
  end

  def self.space_id(space:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE name = $1;", [space])
    result.map do |spaces|
      p spaces['id']
    end
  end

end