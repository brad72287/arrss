class CreateFeeds < ActiveRecord::Migration
 
 create_table :feeds do |t|
   t.string :url
   t.references :user
 end

end