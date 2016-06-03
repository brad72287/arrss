class User < ActiveRecord::Base
    
    has_many :feeds
    has_secure_password
    
end