class CreateTables < ActiveRecord::Migration

 create_table :users do |t|
   t.string :username
   t.string :password_digest
 end
 
 create_table :feeds do |t|
   t.string :url
   t.references :user
 end

end