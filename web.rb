require 'sinatra'
require 'mongo_mapper'
require 'tempfile'

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
