class Bookings
  def self.print_dates
    t = Time.now
    date_array = (0..6).map { |num| t + 86400 * num}
    date_array_formatted = date_array.map {|date| date.strftime("%d-%m-%Y")}
  end
end
