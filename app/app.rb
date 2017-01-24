ENV['RACK_ENV'] ||= "development"

require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  get '/' do
    'Homepage'
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/new' do
    erb :new
  end

  post '/newbookmark' do
    Link.create(url: params[:url], title: params[:title])
    redirect '/links'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
