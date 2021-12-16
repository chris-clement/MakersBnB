feature 'Viewing booking request' do
  scenario 'user is able to see if their space has been requested to book' do
    login_and_visit_home
    click_on('Check Request')
    expect(page).to have_content('Current Booking Request:')
  end

  scenario 'user is able to see which space has been requested to book' do
    Bookings.add_booking('18-12-2021')
    login_and_visit_home
    click_on('Check Request')
    expect(page).to have_content('London Road, 18-12-2021')
  end
end