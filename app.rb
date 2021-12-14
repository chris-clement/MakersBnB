# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/reloader'
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
