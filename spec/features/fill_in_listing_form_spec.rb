feature 'filling in form' do

  scenario 'user can fill in form' do
    visit '/makersbnb/list_a_space'
    fill_in('Space Name',with: 'My Space')
    fill_in('Price',with: '100000')
    fill_in('Description',with: 'A lovely space')
  end

end