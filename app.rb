require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookings'
require './setup_database'

class MakersBnb < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello world!'
  end

  get '/add_booking' do
    erb :add_booking
  end

  get '/booking/date_selection' do
    @dates = Bookings.print_dates
    @checked_availability = Bookings.check_availability(@dates)
    erb :booking_date_selection
  end

  get '/booking/confirm_booking/:date' do
    p params
    Bookings.add_booking(params[:date])
    erb :booking_confirm_booking
  end

end