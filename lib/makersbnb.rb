require './lib/database_connection'

class MakersBnb_Listings

  def self.create_space(space_name:, price:, description:, user_id:)
    DatabaseConnection.query("INSERT INTO spaces (name, price, description, user_id) VALUES($1, $2, $3, $4) RETURNING name, price, description;", [space_name, price, description, user_id]
      )
  end

  def self.exist?(space_name:)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE name = $1;",[space_name])
    @unsuccessful = !result.to_a.empty?
    
  end 

  def self.unsuccessful 
    @unsuccessful 
  end

  def self.view_listings
    result = DatabaseConnection.query("SELECT * FROM spaces;")
    result.to_a
    
    #, RETURNING name, price, description;", [name, price, description])
    #result.map { |listing| listing['name']}
  end

  def self.view_space_details(id)
    result = DatabaseConnection.query("SELECT * FROM spaces WHERE id = $1;",[id])
    result.to_a
  end

  def self.update_listing(id:, space_name:, price:, description:)
    result = DatabaseConnection.query("UPDATE spaces SET description = $4, price = $3, name = $2  WHERE id = $1 ", [id,space_name,price,description])
  end
end