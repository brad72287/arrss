class User < ActiveRecord::Base
    
    has_many :feeds
    has_secure_password
    
    def sort_feeds
        arr=[]
        self.feeds.all.each do |feed|
            feed = RSS::Parser.parse(feed.url)
            feed.items.each do |item| 
                arr << {date: item.pubDate, title: item.title, link: item.link, channel: feed.channel.title, summary: item.description}
            end
        end
        arr.sort_by {|x| x[:date]}.reverse
    end
    
end