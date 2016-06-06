require './config/environment'
require 'rss'
require 'open-uri'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_duper_secure"
  end
  
  get "/" do
  	redirect "/feeds" if logged_in?
	erb :index
  end

  get "/signup" do
	redirect "/feeds" if logged_in?
	erb :signup
  end

  post "/signup" do
    user = User.new(username: params[:username], password: params[:password])
    redirect "/signup?message=You must fill a username!" if user.username.empty?
    if user.save && user.authenticate(params[:password])
        	session[:user_id] = user.id
        	redirect "/feeds"
    	else
        	redirect "/signup?message=Something went wrong. Failed to sign up."
    end
  end
  
  post "/login" do
	user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
            redirect "/feeds"
        else
            redirect "/?message=Failed to login. Make certain that you have the correct username/password!"
    end
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
		User.find(session[:user_id])
	end
  end
  
end