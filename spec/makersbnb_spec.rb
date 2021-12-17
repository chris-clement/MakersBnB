require 'makersbnb'

describe MakersBnb_Listings do

  it 'Adds listing details into the spaces table' do
    MakersBnb_Listings.create_space(space_name: 'Another Space',price: '1',description: 'This is also a space', user_id: 1)
    connection = PG.connect(dbname: 'makers_bnb_test')
    result = connection.exec('SELECT * FROM spaces')
    expect(result.map {|spaces| p spaces['name'] }).to include('Another Space')
  end

  it 'can check if a user space is unique' do 
    MakersBnb_Listings.create_space(space_name: 'Another Space',price: '1',description: 'This is also a space', user_id: 1)
    expect(MakersBnb_Listings.exist?(space_name: 'Another Space')).to eq true 
  end

  it '.view_listings' do
    MakersBnb_Listings.create_space(space_name: 'Another Space',price: '1',description: 'This is also a space', user_id: 1)
    DatabaseConnection.query('SELECT * FROM spaces')
    expect(MakersBnb_Listings.view_listings[0]['name']).to eq('Another Space')
    expect(MakersBnb_Listings.view_listings[0]['id']).to eq('1')
  end
  
end