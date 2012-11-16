L.A.D.
===

L :: Link 
A :: Aggregation 
D :: Display 

Is a web front-end for a link aggregation bot. This is built using Sinatra, Cinch, Mongomapper and MongoDB. Currently it is designed to be hosted on heroku and can be run for free. You just need to add the mongolab add-on to your heroku app.

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
* Make page responsive
