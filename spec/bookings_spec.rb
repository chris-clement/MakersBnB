require 'bookings'
require 'database_connection'

describe Bookings do 

  describe '.print_dates' do
    it 'would show the next 7 days' do
      expect(Bookings.print_dates).to include Time.now.strftime("%d-%m-%Y")
      expect(Bookings.print_dates).to include (Time.now + 3 * 86400).strftime("%d-%m-%Y")
    end
  end

  describe '.check_availability' do
    context 'user has not approved or disapproved yet' do
      it 'returns Available' do
        DatabaseConnection.query("INSERT INTO bookings(date) VALUES ($1);", ['15-12-2021' ])
        expect(Bookings.check_availability(['15-12-2021'])).to eq ['Available']
      end
    end
    context 'user has approved the booking' do
      it 'returns not Available' do
        DatabaseConnection.query("INSERT INTO bookings(date, approved) VALUES ($1, $2);", ['15-12-2021', true])
        expect(Bookings.check_availability(['15-12-2021'])).to eq ['Not Available']

      end
    end
    context 'user has disapproved the booking' do
      it 'returns Available' do
        DatabaseConnection.query("INSERT INTO bookings(date, approved) VALUES ($1, $2);", ['15-12-2021', false])
        expect(Bookings.check_availability(['15-12-2021'])).to eq ['Available']
      end
    end
  end

  describe '.add_booking' do
    it 'adds booking to database' do
      Bookings.add_booking('20-12-2021')
      expect(Bookings.check_availability(['20-12-2021'])).to eq ['Available']
    end
  end
  
  describe '.booked_date' do
    it 'returns all dates that have been booked' do
      Bookings.add_booking('20-12-2021')
      Bookings.add_booking('22-12-2021')
      Bookings.add_booking('25-12-2021')
      expect(Bookings.booked_dates).to eq ['20-12-2021', '22-12-2021', '25-12-2021']
    end
  end

  describe '.approved?' do
    context 'a date has been approved'
    it 'returns true' do
      Bookings.add_booking('20-12-2021')
      Bookings.approve_booking('20-12-2021')
      expect(Bookings.approved?(['20-12-2021'])).to eq [true]
    end

    context 'a date has been disapproved'
    it 'returns false' do
      Bookings.add_booking('20-12-2021')
      Bookings.disapprove_booking('20-12-2021')
      expect(Bookings.approved?(['20-12-2021'])).to eq [false]
    end

    context 'a date has not been approved or dissaproved'
    it 'returns false' do
      Bookings.add_booking('20-12-2021')
      expect(Bookings.approved?(['20-12-2021'])).to eq ['pending']
    end
  end
end