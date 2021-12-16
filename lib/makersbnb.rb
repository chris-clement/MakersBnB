require './lib/database_connection'

class MakersBnb_Listings

  def self.create_space(space_name:, price:, description:)
    DatabaseConnection.query("INSERT INTO spaces (name, price, description) VALUES($1, $2, $3) RETURNING name, price, description;", [space_name, price, description]
    )
  end

  def self.exist?(space_name:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE name = $1;",[space_name])
    @unsuccessful = !result.to_a.empty?
    
  end 

  def self.unsuccessful 
    @unsuccessful 
  end
end