require 'database_connection'

feature 'Add bookings' do
    scenario 'A user should be able to click on book now and see a available dates' do
        visit('/add_booking')
        click_on('Book Now')
        expect(page).to have_content(Time.now.strftime("%d-%m-%Y"))
    end
end

feature 'After clicking book now, a user sees if a date is available' do
    scenario 'A user should be able to see if a date is available' do
        DatabaseConnection.query("INSERT INTO bookings(date) VALUES ($1);", ['15-12-2021'])
        visit('/add_booking')
        click_on('Book Now')
        expect(page).to have_content('Available')
        expect(page).to have_content('Not Available')
    end
end