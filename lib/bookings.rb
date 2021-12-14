require 'pg'
require 'database_connection'
class Bookings
  def self.print_dates
    t = Time.now
    date_array = (0..6).map { |num| t + 86400 * num}
    date_array_formatted = date_array.map {|date| date.strftime("%d-%m-%Y")}
  end

  def self.check_availability(space_id, date)
    result = DatabaseConnection.query("SELECT space_id, date FROM bookings;", [])
    if result.count == 0
      'Available'
    else
      'Not Available'
    end
  end
end
