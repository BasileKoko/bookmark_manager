ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require 'sinatra/flash'

class BookmarkManager < Sinatra::Base
use Rack::MethodOverride

  enable :sessions
  register Sinatra::Flash
  set :session_secret, 'super secret'


  helpers do
    def current_user
      @current_user ||= User.get(session[:user])
    end
  end

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/new' do
    @user = User.new
    erb :new
  end

  post '/newbookmark' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split(' ').each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect '/links'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :links
  end

  get '/signup' do
    @user = User.new
    erb :signup
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'goodbye!'
    redirect to '/links'
    end

  post '/users' do
    @user = User.create(email: params[:email],
                       password: params[:password],
                       password_confirmation: params[:password_confirmation])

    if @user.save
      session[:user] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :signup
    end
  end
  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME
end
