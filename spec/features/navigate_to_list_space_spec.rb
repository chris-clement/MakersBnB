feature 'can navigate to list space' do

  scenario 'can click button to go to list space' do
    # We need to log in first
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: 'password')
    click_on('Login')
    click_on('List a Space')
    expect(page).to have_field('Name',placeholder: 'My Awesome Space')
  end
end