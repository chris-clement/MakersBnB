require 'sinatra/base'
require 'sinatra/reloader'
require_relative './lib/makersbnb'

class MakersBnb < Sinatra::Base 
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
   redirect '/home'
  end

  get '/home' do
    erb :'homepage'
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

end