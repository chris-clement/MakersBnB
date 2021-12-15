feature 'Viewing booking request' do
  scenario 'user is able to see if their space has been requested to book' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: 'password')
    expect(current_path).to eq '/login'
    click_on('Login')
    click_on('Check Request')
    expect(page).to have_content('Current Booking Request:')
  end

  scenario 'user is able to see which space has been requested to book' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    Bookings.add_booking('18-12-2021')
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: 'password')
    expect(current_path).to eq '/login'
    click_on('Login')
    click_on('Check Request')
    expect(page).to have_content('London Road, 18-12-2021')
  end
end