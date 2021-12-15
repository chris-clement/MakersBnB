# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/bookings'
require_relative './lib/makersbnb'
require './lib/user'
require './database_connection_setup'


# App class
class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions
  register Sinatra::Flash

  get '/' do
     erb :index
  end

  get '/home' do
    if User.valid(session[:username], session[:password])
      @username = session[:username]
      erb :home
    else
      flash[:notice] = 'Invalid username or password'
      redirect '/login'
    end
  end

  get '/login' do
    erb :login
  end

  post '/user_details' do
    session[:username] = params[:username]
    session[:password] = params[:password]
    redirect '/home'
  end

  get '/list_a_space' do
    erb :'list_a_space'
  end

  post '/listing_created' do
    if MakersBnb_Listings.exist?(space_name: params[:Name])
        redirect '/list_a_space'
    else
      MakersBnb_Listings.create_space(space_name: params[:Name], price: params[:Price], description: params[:Description])
      @space_name = params[:Name]
      @price = params[:Price]
      @description = params[:Description]
      erb :'listing_created_success'
    end
  end

  get '/add_booking' do
    erb :add_booking
  end

  # We want space name variable as the route instead of 'booking'
  get '/booking/date_selection' do
    @dates = Bookings.print_dates
    @checked_availability = Bookings.check_availability(@dates)
    erb :booking_date_selection
  end

  # We want space name variable as the route instead of 'booking'
  get '/booking/confirm_booking/:date' do
    Bookings.add_booking(params[:date])
    @date_booked = params[:date]
    erb :booking_confirm_booking
  end

  get '/check_request' do
    @booked_dates = Bookings.booked_dates
    @approved_array = Bookings.approved?(@booked_dates)
    erb :check_request
  end

  post '/check_request/:date' do
    Bookings.approve_booking(params[:date])
    redirect '/check_request'
  end

end
