feature 'Approve a booking request' do
  scenario 'a user requested to book a date and I approve it' do
    Bookings.add_booking("#{today_date}")
    login_and_visit_home
    click_on('Check Request')
    click_on('Approve')
    expect(page).to have_content("#{today_date} - Approved")
  end
end

feature 'Disapprove a booking request' do
  scenario 'a user requested to book a date and I disapprove it' do
    Bookings.add_booking("#{today_date}")
    login_and_visit_home
    click_on('Check Request')
    click_on('Disapprove')
    expect(page).to have_content("#{today_date} - Disapproved")
  end
end