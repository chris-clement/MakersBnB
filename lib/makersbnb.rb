require 'pg'

class MakersBnb_Listings

  def self.create_space(space_name:, price:, description:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
    else
      connection = PG.connect(dbname: 'makers_bnb')
    end
    connection.exec_params("INSERT INTO spaces (name, price, description) VALUES($1, $2, $3) RETURNING name, price, description;", [space_name, price, description]
    )
  end

  def self.exist?(space_name:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'makers_bnb_test')
    else
      connection = PG.connect(dbname: 'makers_bnb')
    end
    result = connection.exec_params("SELECT * FROM spaces WHERE name = $1;",[space_name])
    @unsuccessful = !result.to_a.empty?
    
  end 

  def self.unsuccessful 
    @unsuccessful 
  end
end