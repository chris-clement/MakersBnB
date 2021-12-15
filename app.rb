# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
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

  get '/makersbnb/list_a_space' do
    erb :'list_a_space'
  end

  post '/makersbnb/listing_created' do
    if MakersBnb_Listings.exist?(space_name: params[:Name])
        redirect '/makersbnb/list_a_space'
    else
      MakersBnb_Listings.create_space(space_name: params[:Name], price: params[:Price], description: params[:Description])
      @space_name = params[:Name]
      @price = params[:Price]
      @description = params[:Description]
      erb :'listing_created_success'
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

  get '/home' do
    if User.valid(session[:username], session[:password])
      @username = session[:username]
      erb :home
    else
      flash[:notice] = 'Invalid username or password'
      redirect '/login'
    end
  end
end

