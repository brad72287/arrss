class FeedController < ApplicationController

	get "/feeds" do
	  redirect "/" if !logged_in?
	  @feeds = current_user.feeds
	  erb :"feeds/index"
	end
	
	get "/feeds/manage" do
		redirect "/" if !logged_in?
		@feeds = current_user.feeds
		erb :"feeds/manage"
	end
	
	post "/feeds/manage" do
		if RSS::Parser.parse(params[:url]).nil?
			redirect '/feeds/manage?message=The RSS feed is not valid.'
		end
		current_user.feeds << Feed.new(url: params[:url]) 
		current_user.save
		redirect '/feeds/manage?message=Successfully added the RSS feed!'
	end
	
	post "/feeds/:id/delete" do
		@feed = current_user.feeds.find(params[:id])
		@feed.destroy
		redirect '/feeds'
	end 

end