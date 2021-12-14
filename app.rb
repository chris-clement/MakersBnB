require 'sinatra/base'
require 'sinatra/reloader'

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
    erb :booking_date_selection
  end

end