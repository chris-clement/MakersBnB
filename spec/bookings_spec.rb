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
    context 'space is unavailable for that date' do
      it 'returns Not Available' do
        DatabaseConnection.query("INSERT INTO bookings(date) VALUES ($1);", ['15-12-2021' ])
        expect(Bookings.check_availability(['15-12-2021'])).to eq ['Not Available']
      end
    end
    context 'space is available for that date' do
      it 'returns Available' do
        expect(Bookings.check_availability(['15-12-2021'])).to eq ['Available']
      end
    end
  end
end