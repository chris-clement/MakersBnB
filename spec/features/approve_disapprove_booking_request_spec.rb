feature 'Approve a booking request' do
  scenario 'a user requested to book a date and I approve it' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    Bookings.add_booking('18-12-2021')
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: 'password')
    click_on('Login')
    click_on('Check Request')
    click_on('Approve')
    expect(page).to have_content('18-12-2021 - Approved')
  end
end

feature 'Disapprove a booking request' do
  scenario 'a user requested to book a date and I disapprove it' do
    DatabaseConnection.query("INSERT INTO users(username, password) VALUES('firstuser', 'password');")
    Bookings.add_booking('18-12-2021')
    go_to_login_page
    fill_in('username', with: 'firstuser')
    fill_in('password', with: 'password')
    click_on('Login')
    click_on('Check Request')
    click_on('Disapprove')
    expect(page).to have_content('18-12-2021 - Disapproved')
  end
end