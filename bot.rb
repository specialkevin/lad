require 'cinch'
require 'open-uri'

require 'mongo_mapper'
require_relative 'models'


bot = Cinch::Bot.new do

    configure do |c|
        c.server = "irc.oftc.net"
        c.nick = "ladbot"
        c.channels = ["#irlab2"]
    end

    on :message, "hello" do |m|
        m.reply "Hello, #{m.user.nick}"
    end

    on :message, "link last" do |m|
        m.reply Link.last(:order => :datePosted.asc).url
    end


    on :channel do |m|
        urls = URI.extract(m.message)
        unless urls.empty?

            urls.each do |url|
                link = Link.new
                link.url = url
                link.submitter = m.user.nick
                link.datePosted = Time.now
                puts url
                content = open(url)
                puts content.content_type
                type = content.content_type
                if type.include? 'image'
                    link.isPhoto = true
                    puts "is image"
                else
                    link.isPhoto = false
                end
                link.save

            end
        end
    end
end

bot.start

