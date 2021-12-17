# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './lib/bookings'
require_relative './lib/makersbnb'
require './lib/user'
require './database_connection_setup'
require_relative './lib/update'


# App class
class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions
  register Sinatra::Flash

  get '/' do
    @listings = MakersBnb_Listings.view_listings
    erb :index
  end

  get '/home' do
    if User.valid(session[:username], session[:password])
      session[:user_id] = User.user_id(username: session[:username])
      @listings = MakersBnb_Listings.view_listings
      @username = session[:username]
      erb :home
    else
      flash[:notice] = 'Invalid username or password'
      redirect '/login'
    end
    
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up_details' do
    flash[:notice] = 'Thanks for signing up to MakersBnB'
    User.create_user(params[:username], params[:password], params[:email], params[:phone_number])
    redirect '/login'
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
      MakersBnb_Listings.create_space(space_name: params[:Name], price: params[:Price], description: params[:Description], user_id: session[:user_id  ])
      @space_name = params[:Name]
      @price = params[:Price]
      @description = params[:Description]
      erb :'listing_created_success'
    end
  end

  # We want space name variable as the route instead of 'booking'
  get '/booking/date_selection/:id' do
    session[:space_id] = params[:id]
    @dates = Bookings.print_dates
    @checked_availability = Bookings.check_availability(@dates, session[:space_id])
    erb :booking_date_selection
  end

  # We want space name variable as the route instead of 'booking'
  get '/booking/confirm_booking/:id/:date' do
    Bookings.add_booking(params[:date], session[:space_id], session[:user_id])
    @date_booked = params[:date]
    erb :booking_confirm_booking
  end


  get '/update_booking' do
    erb :update_booking
  end

  get '/edit_listing/:spaces' do
    erb :edit_listing
  end

  get '/change_listing_days/:spaces' do
    session[:space_id] = params[:spaces] 
      if Updater.confirm_user(space_id: session[:space_id], user_id: session[:user_id])
        @dates = Bookings.print_dates
        @checked_availability = Bookings.check_availability(@dates, session[:space_id])
        erb :change_listing_days
      else
        'YOU CANNOT ACCESS THIS PAGE'
      end
    end

    get '/change_listing_days_unavailable/:date' do
      Bookings.add_booking(params[:date], session[:space_id], session[:user_id])
      Bookings.approve_booking(params[:date], session[:space_id], session[:user_id])
      redirect '/update_booking'
    end

    get '/change_listing_days_available/:date' do
      Bookings.remove_booking(params[:date], session[:space_id], session[:user_id])
      redirect '/update_booking'
    end

  get '/check_request' do
    @user_spaces = Updater.list(id: session[:user_id])
    "HELLO" 
    p Updater.space_id(space: @user_spaces[0])[0].to_i
    @user_spaces_id = []
    @booked_dates = []
    @user_spaces.each do |space_1|
      @user_spaces_id << Updater.space_id(space: space_1).first.to_i
      Bookings.booked_dates(Updater.space_id(space: space_1)).each do |date| 
        @booked_dates << [space, date]
      end
    end
    @approved_array = Bookings.approved?(@booked_dates)


    erb :check_request
  end

  get '/check_request/approve/:date' do
    Bookings.approve_booking(params[:date])
    redirect '/check_request'
  end

  get '/check_request/disapprove/:date' do
    Bookings.disapprove_booking(params[:date])
    redirect '/check_request'
  end


end
