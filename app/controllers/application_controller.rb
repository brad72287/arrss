require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
		set :session_secret, "super_duper_secure"
  end
  
  get "/" do
		erb :index
	end

	get "/signup" do
	  redirect "/tweets" if logged_in?
		erb :signup
	end

	post "/signup" do
      user = User.new(username: params[:username], email: params[:email], password: params[:password])
      redirect "/signup" if user.username.empty? || user.email.empty?
      if user.save && user.authenticate(params[:password]) &&  
          session[:user_id] = user.id
          redirect "/tweets"
      else
          redirect "/signup"
      end
  end


	get "/login" do
	  redirect "/tweets" if logged_in?
		erb :login
	end

	post "/login" do
		user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect "/login"
        end
	end

	get "/logout" do
		session.clear
		redirect "/login"
	end
	
	#*************TWEETS***************#

	get "/tweets" do
	  if logged_in?
	  	@tweets = Tweet.all
		  erb :'tweets/index'
		else
		  redirect "/login"
	  end
	end
	
	get "/tweets/new" do
		gtfo
		erb :"tweets/new"
	end
	
	get "/users/:slug" do
		@user = User.find_by_slug(params[:slug])
		erb :"tweets/show"
	end
	
	get '/tweets/:id/edit' do 
		gtfo
		@tweet = Tweet.find(params[:id])
		erb :'tweets/edit'
	end
	
	post '/tweets/:id/edit' do 
		redirect "tweets/#{params[:id]}/edit" if params[:content].empty?
		@tweet = Tweet.find(params[:id])
		@tweet.content = params[:content]
		@tweet.save
		redirect '/tweets'
	end
	
	post '/tweets/:id/delete' do 
		gtfo
		redirect '/tweets' if current_user != User.find(Tweet.find(params[:id]).user_id)
		@tweet = Tweet.find(params[:id])
		@tweet.destroy
		redirect '/tweets'
	end
	
	post "/tweets/new" do
		redirect 'tweets/new' if params[:content].empty?
		current_user.tweets << Tweet.new(content: params[:content]) 
		current_user.save
		redirect '/tweets'
	end
	
	get "/tweets/:id" do
		gtfo 
		@tweet = Tweet.find(params[:id])
		erb :'tweets/individual'
	end

	#*************TWEETS***************#

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