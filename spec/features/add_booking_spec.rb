feature ' Add bookings ' do
    scenario 'A user should be able to book a space' do
        visit('/add_booking')
        click_on ('Book Now')
        expect(page).to have_content('example date 1')
    end
end