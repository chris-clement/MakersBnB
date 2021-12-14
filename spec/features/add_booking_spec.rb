feature ' Add bookings ' do
    scenario 'A user should be able to click on book now and see a available dates' do
        visit('/add_booking')
        click_on('Book Now')
        expect(page).to have_content('example date 1')
    end
end