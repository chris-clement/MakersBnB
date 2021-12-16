feature 'Update Space page' do

  scenario 'A user should be able to get to the update space page' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    login_and_visit_home
    click_on('Update a Space')
    expect(page).to have_content("My Spaces")
  end

  scenario 'The spaces of the user are listed on the update space page' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    login_and_visit_home
    create_listing('My Place')
    create_listing('My Place Two')
    visit'/home'
    click_on('Update a Space')
    expect(page).to have_content('My Place')
    expect(page).to have_content('My Place Two')
  end

end