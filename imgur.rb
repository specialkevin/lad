require 'httparty'

class Imgur
    include HTTParty
    base_uri 'https://api.imgur.com/3'
    format :json

    def image(id)
        self.class.get('/image/'+id, :headers => {'Authorization' => 'Client-ID f21426d9b585044'})
    end
end
