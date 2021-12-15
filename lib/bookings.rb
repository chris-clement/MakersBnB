require 'pg'
require './lib/database_connection'
class Bookings
  def self.print_dates
    t = Time.now
    date_array = (0..6).map { |num| t + 86400 * num}
    date_array_formatted = date_array.map {|date| date.strftime("%d-%m-%Y")}
  end

  def self.check_availability(dates = [])
    dates.map do |date|
      result = DatabaseConnection.query("SELECT space_id, date FROM bookings WHERE date = $1 AND approved = $2;", [date, true])
      if result.count == 0
        "Available"
      else
        "Not Available"
      end
    end
  end

  def self.add_booking(date)
    DatabaseConnection.query("INSERT INTO bookings(date) VALUES($1);", [date])
  end
    
  def self.booked_dates
    dates = DatabaseConnection.query("SELECT date FROM bookings;")
    dates.map { |date| date['date'] }
  end
  
  def self.approve_booking(date)
   DatabaseConnection.query("UPDATE bookings SET approved = true WHERE date=$1;", [date])
  end

  def self.disapprove_booking(date)
    DatabaseConnection.query("UPDATE bookings SET approved = false WHERE date=$1;", [date])
  end

  def self.approved?(dates = []) 
    dates.map do |date|
      result = DatabaseConnection.query("SELECT approved FROM bookings WHERE date=$1;", [date])
      if result.first['approved'] == 't'
        true
      elsif result.first['approved'] == 'f'
        false
      else
        'pending'
      end
    end
  end
end
