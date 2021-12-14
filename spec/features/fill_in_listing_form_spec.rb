feature 'filling in form' do

  scenario 'user can fill in form' do
    visit '/makersbnb/list_a_space'
    fill_in('Name',with: 'My Space')
    fill_in('Price',with: '100000')
    fill_in('Description',with: 'A lovely space')
  end

  scenario 'once completed, a pop up will state the listing has been created ' do
    visit '/makersbnb/list_a_space'
    fill_in('Name',with: 'My Space')
    fill_in('Price',with: '100000')
    fill_in('Description',with: 'A lovely space')
    click_on('Submit')
    expect(page).to have_content("Listing Created")
  end

end