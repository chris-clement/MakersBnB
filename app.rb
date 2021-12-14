require 'sinatra/base'
require 'sinatra/reloader'
require './database_connection_setup.rb'

class MakersBnb < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/login' do
    erb :login
  end

  post '/home' do
    erb :home
  end
end