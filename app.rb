require 'sinatra/base'
require 'sinatra/reloader'
require './lib/bookings'

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
    erb :booking_date_selection
  end

end