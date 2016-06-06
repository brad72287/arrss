ENV['SINATRA_ENV'] ||= "development" 

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)


require_all 'app' #Tired of futzing around with require statements everywhere, littering your code with require File.dirname(__FILE__) crap? What if you could just point something at a big directory full of code and have everything just automagically load regardless of the dependency structure?
