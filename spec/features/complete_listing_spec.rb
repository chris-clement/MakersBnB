feature 'completing form' do
  scenario 'Once the form is completed, it is stored on the database' do
    create_listing('My Space')
    connection = PG.connect(dbname: 'makers_bnb_test')
    result = connection.exec('SELECT * FROM spaces')
    expect(result.map {|spaces| p spaces['name'] }).to include('My Space')
  end

end