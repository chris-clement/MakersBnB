# frozen_string_literal: true

feature 'we can log in' do
  scenario 'from landing page we can go to the login page' do
    go_to_login_page
    expect(page).to have_content 'Welcome to MakersBnB'
  end

  scenario 'fill out log in form with username and password' do
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: 'password')
    expect(current_path).to eq '/login'
    click_on('Login')
    expect(page).to have_content 'firstuser'
  end
end

feature 'not possible to login' do
  scenario 'should not login if given wrong username and/or password' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: '3445656')
    expect(current_path).to eq '/login'
    click_on('Login')
    expect(page).to have_content "Welcome to MakersBnB\nInvalid username or password"
  end
end
