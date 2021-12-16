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

   def self.confirm_user(space_id:, user_id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id = $1 AND user_id = $2;", [space_id, user_id])
    if result.count == 0
      false
    else
      true
    end
  end 

end