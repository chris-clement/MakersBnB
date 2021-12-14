feature 'completing form' do

  scenario 'Once the form is completed, it is stored on the database' do
    visit '/makersbnb/list_a_space'
    fill_in('Name',with: 'My Space')
    fill_in('Price',with: '100000')
    fill_in('Description',with: 'A lovely space')
    click_on('Submit')
    connection = PG.connect(dbname: 'makers_bnb_test')
    result = connection.exec('SELECT * FROM spaces')
    expect(result.map {|spaces| p spaces['name'] }).to include('My Space')
  end

  scenario 'If the form is incorrectly completed, it is not stored on the database' do
    visit '/makersbnb/list_a_space'
    fill_in('Name',with: 'My Second Space')
    fill_in('Description',with: 'A lovely space')
    click_on('Submit')
    connection = PG.connect(dbname: 'makers_bnb_test')
    result = connection.exec('SELECT * FROM spaces')
    expect(result.map {|spaces| p spaces['name'] }).not_to include('My Second Space')
  end

end