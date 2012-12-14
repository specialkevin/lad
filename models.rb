require 'mongo_mapper'
require 'joint'

puts ENV['MONGOLAB_URI']
regex_match = /.*:\/\/(.*):(.*)@(.*):(.*)\//.match(ENV['MONGOLAB_URI'])
host = regex_match[3]
port = regex_match[4]
db_name = regex_match[1]
pw = regex_match[2]

MongoMapper.connection = Mongo::Connection.new(host, port)
MongoMapper.database = db_name
MongoMapper.database.authenticate(db_name, pw)

class Link
    include MongoMapper::Document
    plugin Joint

    key :url, String
    key :datePosted, Time
    key :submitter, String
    key :isPhoto, Boolean
    key :isGithubRepo, Boolean
    key :isVideo, Boolean

    attachment :photo
end
