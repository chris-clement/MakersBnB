require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/makersbnb'

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

  post '/makersbnb/listing_created' do
    if MakersBnb_Listings.exist?(space_name: params[:Name])

    end
    MakersBnb_Listings.create_space(space_name: params[:Name], price: params[:Price], description: params[:Description])
    redirect '/makersbnb/listing_created_success'
  end

  get '/makersbnb/listing_created_success' do
    "Listing Created"
  end

  get '/makersbnb/listing_created_failure' do
  end
end