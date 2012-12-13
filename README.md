L.A.D.
===

![L.A.D.](http://farm8.static.flickr.com/7175/6414704693_72270d49b0.jpg)

L.A.D. is a link bot with a sexy web front-end for a link aggregation bot. The bot currently will parse out images and Github repos from links to display in seperate tabs.

RQUIREMENTS
-----------

* Heroku App
* MongoLab Heroku Add-on
* Sinatra
* Cinch
* MongoMapper
* tint

SETUP
-----

```
git clone git://github.com/specialkevin/lad.git
heroku create
heroku heroku addons:add mongolab
heroku config:add IRC_SERVER=<irc server>
heroku config:add IRC_CHANNEL=<irc channel>
heroku config:add IRC_NICK=<irc bot nick>
git push heroku master
```

FUTURE
------
* Add image caching
* Pull out videos into seperate page
* Pull out github links into seperate page
