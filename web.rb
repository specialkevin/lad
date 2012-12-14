require 'sinatra'
require 'mongo_mapper'
require 'octokit'

require_relative 'models'

get "/" do
    @links = Link.where(:isPhoto => false).sort(:datePosted.desc)
    erb :index
end

get '/last' do
    @last_link = Link.last(:order => :datePosted.desc).url
    erb :last
end

get '/user/:user' do
    username = params[:user]
    @links = Link.where(:submitter => username).sort(:datePosted.desc)
    erb :user
end

get '/photos' do
    @links = Link.where(:isPhoto => true).sort(:datePosted.desc)
    erb :photos
end

get '/photo/:id' do |id|
    link = Link.where(:id => id).first()
    photo = link.photo
    [200, {'Content-Type' => photo.content_type}, [photo.read]]
end

get '/repos' do
    links = Link.where(:isGithubRepo => true).sort(:datePosted.desc)
    @repos = []
    for repo in links
        @repos << Octokit.repo(repo.url.split('/', 4).last)
    end
    erb :repos
end

get '/videos' do
    @links = Link.where(:isVideo => true).sort(:datePosted.desc)
    erb :index
