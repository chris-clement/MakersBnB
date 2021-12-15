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

feature 'Booking confirmed once you click to book an available date' do
    scenario 'A user should be able to book an available date' do
        DatabaseConnection.query("INSERT INTO bookings(date) VALUES ($1);", ['15-12-2021'])
        visit('/add_booking')
        click_on('Book Now')
        first(:button, 'Book').click
        expect(page).to have_content 'Booking confirmed'
    end
end

feature 'Booking disables availability of that date' do
    scenario 'A user should be able to book an available date and then it becomes unavailable' do
        visit('/add_booking')
        click_on('Book Now')
        first(:button, 'Book').click
        click_on 'Back to dates'
        expect(page).to have_content "#{Time.now.strftime("%d-%m-%Y")} Not Available"
    end
end

feature 'Confirmation page specifies date which has been booked' do
    scenario 'A user books an available date and gets confirmation for the date they have booked' do
        visit('/add_booking')
        click_on('Book Now')
        first(:button, 'Book').click
        expect(page).to have_content "Booking confirmed for #{Time.now.strftime("%d-%m-%Y")}"
    end
end