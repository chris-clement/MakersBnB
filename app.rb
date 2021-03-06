# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
require './database_connection_setup'
require './lib/bookings'
require_relative './lib/makersbnb'
require './lib/user'
require_relative './lib/update'
require './lib/images'


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
    if User.unique_username(params[:username]) == true
      flash[:notice] = 'Thanks for signing up to MakersBnB'
      User.create_user(params[:username], params[:password], params[:email], params[:phone_number])
      redirect '/login'
    else
      flash[:notice] = 'This username has been taken - please choose a different one!'
      redirect '/sign_up'
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
      MakersBnb_Listings.create_space(space_name: params[:Name], price: params[:Price], description: params[:Description], user_id: session[:user_id])
      Images.save_url(params[:Name], params[:space_url])
      @image_url = Images.url_by_space(params[:Name])
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
    @checked_availability = Bookings.is_the_booking_pending?(@dates, session[:space_id], session[:user_id])
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
    session[:space_id] = params[:spaces] 
    if Updater.confirm_user(space_id: session[:space_id], user_id: session[:user_id])
      @dates = Bookings.print_dates
      @checked_availability = Bookings.check_availability(@dates, session[:space_id])
      space_details = MakersBnb_Listings.view_space_details(session[:space_id])[0]
      p space_details
      @space_name = space_details['name']
      @price = space_details['price']
      @description = space_details['description']
      erb :edit_listing 
    else
      'YOU CANNOT ACCESS THIS PAGE'
    end
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
      id = Bookings.locate_booking_id(params[:date], session[:space_id], session[:user_id])['id']
      Bookings.approve_booking(id)
      redirect '/update_booking'
    end

    get '/change_listing_days_available/:date' do
      Bookings.remove_booking(params[:date], session[:space_id], session[:user_id])
      redirect '/update_booking'
    end

  get '/check_request' do
    @user_spaces = Updater.list(id: session[:user_id])
    @user_spaces_id = []
    @booked_dates = []
    @user_spaces.each do |space_1|
      @user_spaces_id << Updater.space_id(space: space_1)[0].to_i
      Bookings.booked_dates(Updater.space_id(space: space_1)[0].to_i).each do |date, id|
        array = [space_1,date, id] 
        @booked_dates << array
      end
    end
    if @booked_dates.nil?
      @booked_dates = ["No-one"]
      @approved_array = ["You have no approvals to do!"]
    else
      @approved_array = Bookings.approved?(@booked_dates)
    end

    erb :check_request
  end

  get '/check_request/approve/:id' do
    Bookings.approve_booking(params[:id])
    redirect '/check_request'
  end

  get '/check_request/disapprove/:id' do
    Bookings.disapprove_booking(params[:id])
    redirect '/check_request'
  end


  post '/listing_updated/:id' do
    MakersBnb_Listings.update_listing(id: params[:id], space_name: params[:Name], price: params[:Price], description: params[:Description])
    @space_name = params[:Name]
    @price = params[:Price]
    @description = params[:Description]
    erb :listing_updated_successfully
  end

  get '/my_bookings' do
    @my_bookings = Bookings.my_bookings(session[:user_id])
    @mapped_bookings = @my_bookings.map do |booking|
      if booking['approved'] == 't' then @approved = 'Approved' elsif booking['approved'] == 'f' then @approved = "Disapproved" else @approved = 'Pending' end
      p booking['date'].to_s + " - " + Updater.space_name(booking['space_id'])[0].to_s + " - " + "Status:" + 
       @approved
    end
    erb :my_bookings
  end

end
