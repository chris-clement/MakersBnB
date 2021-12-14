require 'sinatra/base'
require 'sinatra/reloader'

class MakersBnb < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    'Hello world!'
  end

  get '/makersbnb/homepage' do
    erb :'homepage'
  end

  get '/makersbnb/list_a_space' do
    erb :'list_a_space'
  end
end