feature 'Viewing booking request' do
  scenario 'user is able to see if their space has been requested to book' do
    login_and_visit_home
    click_on('Check Request')
    expect(page).to have_content('Current Booking Request:')
  end

  scenario 'user is able to see which space has been requested to book' do
    login_and_visit_home
    create_listing('My Space')
    Bookings.add_booking(today_date, 1, 1)
    click_on('Check Request')
    expect(page).to have_content("London Road, #{today_date}")
  end
end