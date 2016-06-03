require './config/environment'
require 'rss'
require 'open-uri'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
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
      redirect "/signup" if user.username.empty?
      if user.save && user.authenticate(params[:password]) &&  
          session[:user_id] = user.id
          redirect "/feeds"
      else
          redirect "/signup"
      end
  end
  
	post "/login" do
		user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/feeds"
        else
            redirect "/"
        end
	end

	get "/logout" do
		session.clear
		redirect "/"
	end
	
	#*************FEEDS***************#

	get "/feeds" do
	  #url = 'http://bits.blogs.nytimes.com/feed/'
	  @feeds = current_user.feeds #RSS::Parser.parse(open(url))
	  erb :"feeds/index"
	end
	
	get "/feeds/manage" do
		@feeds = current_user.feeds
		erb :"feeds/manage"
	end
	
	post "/feeds/manage" do
		if RSS::Parser.parse(params[:url]).nil?
			puts "Invalid RSS feed" 
			redirect '/feeds'
		end
		current_user.feeds << Feed.new(url: params[:url]) 
		current_user.save
		redirect '/feeds'
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
		
		def gtfo
			redirect '/login' if !logged_in?
		end
	end
  

end