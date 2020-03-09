require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #your code here
    @user = User.new 
    @user.username = params[:username]
    @user.password = params[:password]
    if @user.save 
      redirect '/login'
    elsif @user.password == nil || @user.username == nil
      redirect '/failure'
    else 
      redirect '/failure'
    end 
    

  end

  get '/account' do
    #User.find(session[:user])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    ##your code here
    login(params[:username, params[:password]])
   
  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      #session[:user_id] = user.id
      User.find(session[:user_id])
    end
    
    def login(username, password)
      user = User.find_by(:username => username, :password => password)
      if user && user.authenticate(password)
          session[:username] = user.username
          redirect '/account'
      else 
        redirect '/failure'
      end 
    end 
    
    
  end

end
