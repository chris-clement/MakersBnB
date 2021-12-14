require 'bookings'

describe Bookings do 
  describe '.print_dates' do
    it 'would show the next 7 days' do
      expect(Bookings.print_dates).to include Time.now.strftime("%d-%m-%Y")
      expect(Bookings.print_dates).to include (Time.now + 3 * 86400).strftime("%d-%m-%Y")
    end
  end
end