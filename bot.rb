require 'cinch'
require 'open-uri'
require 'mongo_mapper'
require 'tempfile'

require_relative 'models'
require_relative 'imgur'


bot = Cinch::Bot.new do

    configure do |c|
        c.server = ENV["IRC_SERVER"]
        c.nick = ENV["IRC_NICK"]
        c.channels = [ENV["IRC_CHANNEL"]]
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
                    tmp = Tempfile.new('tmp')
                    tmp << open(url).read
                    link.photo = tmp
                    puts "is image"
                else
                    link.isPhoto = false
                end
                
                if url.include? 'https://github.com/'
                    link.isGithubRepo = true
                else
                    link.isGithubRepo = false
                end

                if url.include? 'www.youtube.com' or url.include? 'vimeo.com'
                    link.isVideo = true
                    if url.include? 'www.youtube.com' and url.include? '/embed/'
                        video_id = url.split('/').last
                        link.url = 'http://www.youtube.com/watch?v='+video_id
                    elsif url.include? 'www.youtube.com' and url.include? '?feature=player_embedded&'
                        link.url.tap{|s| s.slice!("feature=player_embedded&")}
                    else
                        link.url = url
                else
                    link.isVideo = false
                end

                if url.include? 'http://imgur.com'
                    imgur = Imgur.new
                    image = imgur.image(url.split('/').last)
                    link.isPhoto = true
                    url = image["data"]["link"]
                    link.url = url
                    tmp = Tempfile.new("tmp")
                    tmp << open(url).read
                    link.photo = tmp
                end

                link.save

            end
        end
    end
end

bot.start

