require 'bookings'
require 'database_connection'

describe Bookings do 

  describe '.print_dates' do
    it 'would show the next 7 days' do
      expect(Bookings.print_dates).to include today_date
      expect(Bookings.print_dates).to include (Time.now + 3 * 86400).strftime("%d-%m-%Y")
    end
  end

  describe '.check_availability' do
    context 'user has not approved or disapproved yet' do
      it 'returns Available' do
        DatabaseConnection.query("INSERT INTO bookings(date) VALUES ($1);", [today_date])
        expect(Bookings.check_availability([today_date], 1)).to eq ['Available']
      end
    end
    context 'user has approved the booking' do
      it 'returns not Available' do
        DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
        DatabaseConnection.query("INSERT INTO bookings(date, approved) VALUES ($1, $2);", [today_date, true])
        expect(Bookings.check_availability([today_date], 1)).to eq ['Not Available']

      end
    end
    context 'user has disapproved the booking' do
      it 'returns Available' do
        DatabaseConnection.query("INSERT INTO bookings(date, approved) VALUES ($1, $2);", [today_date, false])
        expect(Bookings.check_availability([today_date], 1)).to eq ['Available']
      end
    end
  end

  describe '.add_booking' do
    it 'adds booking to database' do
      DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
      Bookings.add_booking(today_date, 1, 1)
      expect(Bookings.check_availability([today_date], 1)).to eq ['Available']
    end
  end
  
  describe '.booked_date' do
    it 'returns all dates that have been booked' do
      DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
      Bookings.add_booking('20-12-2021', 1, 1)
      Bookings.add_booking('22-12-2021', 1, 1)
      Bookings.add_booking('25-12-2021', 1, 1)
      expect(Bookings.booked_dates).to eq ['20-12-2021', '22-12-2021', '25-12-2021']
    end
  end

  describe '.approved?' do
    context 'a date has been approved'
    it 'returns true' do
      DatabaseConnection.query("INSERT INTO spaces(price, name, description) VALUES ($1, $2, $3);", [21, 'My Space', 'Great space'])
      Bookings.add_booking(today_date, 1, 1)
      Bookings.approve_booking(today_date)
      expect(Bookings.approved?([today_date])).to eq [true]
    end

    context 'a date has been disapproved'
    it 'returns false' do
      Bookings.add_booking(today_date, 1, 1)
      Bookings.disapprove_booking(today_date)
      expect(Bookings.approved?([today_date])).to eq [false]
    end

    context 'a date has not been approved or dissaproved'
    it 'returns false' do
      Bookings.add_booking(today_date, 1, 1)
      expect(Bookings.approved?([today_date])).to eq ['pending']
    end
  end
end