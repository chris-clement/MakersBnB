require 'pg'
require './lib/database_connection'

class Updater

  def self.list(id:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE user_id = $1;", [id])
    p result.to_s
  end

end