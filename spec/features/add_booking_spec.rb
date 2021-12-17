require 'database_connection'

feature 'Add bookings' do
    scenario 'A user should be able to click on book now and see available dates' do
        DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
        login_and_visit_home
        click_on('Book Now')
        expect(page).to have_content("#{today_date}")
    end
end

feature 'After clicking book now, a user sees if a date is available' do
    scenario 'A user should be able to see if a date is available' do
        DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
        DatabaseConnection.query("INSERT INTO bookings(date, approved) VALUES ($1, $2);", ["#{today_date}", false])
        DatabaseConnection.query("INSERT INTO bookings(date, approved) VALUES ($1, $2);", ["#{(Time.now + 86400).strftime("%d-%m-%Y")}", true])
        login_and_visit_home
        click_on('Book Now')
        expect(page).to have_content('Available')
        expect(page).to have_content('Available')
    end
end

feature 'Booking confirmed once you click to book an available date' do
    scenario 'A user should be able to book an available date' do
        DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
        DatabaseConnection.query("INSERT INTO bookings(date) VALUES ($1);", ["#{Time.now.strftime("%d-%m-%Y")}"])
        login_and_visit_home
        click_on('Book Now')
        first(:button, 'Book').click
        expect(page).to have_content 'Booking confirmed'
    end
end

feature 'Booking disables availability of that date' do
    scenario 'A user should be able to book an available date and then it becomes unavailable' do
        login_and_visit_home
        create_listing('My Space')
        click_on 'Home'
        click_on('Book Now')
        first(:button, 'Book').click
        Bookings.approve_booking("#{today_date}", 1, 1)
        click_on 'Back to dates'
        expect(page).to have_content "#{today_date} - Not Available"
    end
end

feature 'Confirmation page specifies date which has been booked' do
    scenario 'A user books an available date and gets confirmation for the date they have booked' do
        DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
        login_and_visit_home
        click_on('Book Now')
        first(:button, 'Book').click
        expect(page).to have_content "Booking confirmed for #{today_date}"
    end
end