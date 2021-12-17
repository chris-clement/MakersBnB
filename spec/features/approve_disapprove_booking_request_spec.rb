feature 'Approve a booking request' do
  scenario 'a user requested to book a date and I approve it' do
    login_and_visit_home
    create_listing('My Space')
    click_on 'Home'
    Bookings.add_booking("#{today_date}", 1, 1)
    click_on('Check Request')
    click_on('Approve')
    expect(page).to have_content("#{today_date} - Approved")
  end
end

feature 'Disapprove a booking request' do
  scenario 'a user requested to book a date and I disapprove it' do
    DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
     
    
    login_and_visit_home
    Bookings.add_booking("#{today_date}", 1, 1)
    click_on('Check Request')
    click_on('Disapprove')
    expect(page).to have_content("#{today_date} - Disapproved")
  end
end