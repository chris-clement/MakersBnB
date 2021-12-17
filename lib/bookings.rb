require './lib/database_connection'

class Bookings
  def self.print_dates
    t = Time.now
    date_array = (0..6).map { |num| t + 86400 * num}
    date_array_formatted = date_array.map {|date| date.strftime("%d-%m-%Y")}
  end

  def self.check_availability(dates = [], space_id)
    dates.map do |date|
      result = DatabaseConnection.query("SELECT space_id, date FROM bookings WHERE date = $1 AND approved = $2 AND space_id = $3;", [date, true, space_id])
      result.count.zero? ? "Available" : "Not Available"
    end
  end

  def self.add_booking(date, space_id, user_id)
    DatabaseConnection.query("INSERT INTO bookings(date, space_id) VALUES($1, $2);", [date, space_id])
  end

  def self.locate_booking_id(date,space_id,user_id)
    (DatabaseConnection.query("SELECT id FROM bookings WHERE date = $1 AND space_id = $2 AND user_id = $3;", [date, space_id, user_id])).to_a[-1]

  end

  def self.remove_booking(date, space_id, user_id)
    DatabaseConnection.query("DELETE FROM bookings WHERE date = $1 AND space_id = $2 AND user_id = $3;", [date, space_id, user_id])
  end
    
    
  def self.booked_dates(space_id)
    dates = DatabaseConnection.query("SELECT date, id FROM bookings WHERE space_id = $1;", [space_id])
    dates.map { |date| [date['date'], date['id']] }
  end
  
  def self.approve_booking(id)
   DatabaseConnection.query("UPDATE bookings SET approved = true WHERE id=$1;", [id])
  end

  def self.disapprove_booking(id)
    DatabaseConnection.query("UPDATE bookings SET approved = false WHERE id=$1;", [id])
  end

  def self.approved?(dates = []) 
    dates.map do |name, date, id|
      result = DatabaseConnection.query("SELECT approved FROM bookings WHERE id=$1;", [id])
      if result.first['approved'] == 't'
        true
      elsif result.first['approved'] == 'f'
        false
      else
        'pending'
      end
    end
  end

  def self.blocked_off?(id,user_id)
    if result = DatabaseConnection.query("SELECT id FROM bookings WHERE id=$1 AND user_id = $2;", [id, user_id]).to_a.empty?
      return false
    else
      return true
    end
  end
end
