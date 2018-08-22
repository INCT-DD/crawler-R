##
## WARNING:
## TWITTER ALLOWS ONLY ONE STREAM CONNECTION TO THEIR API PER IP
##

# LOAD LIBRARIES

library("streamR")
library("mongolite")

# TWITTER AUTH DATA

consumerKey = ""
consumerSecret = ""
accessToken = ""
accessTokenSecret = ""

# MONGODB AUTH DATA

mongoUser = ""
mongoPasswd = ""
mongoHost = "127.0.0.1"
mongoPort = "27017"

# APP TRACKING DATA

trackKeyword = "doria"
trackFileName = "doriaCollection"
trackTimeout = 15

# APP PERSISTENCE DATA

dbName <- "doria"
dbCollection <- "tweets"

# PERFORM TWITTER AUTH

oauthData <- list(consumer_key = consumerKey,
                  consumer_secret = consumerSecret,
                  access_token = accessToken,
                  access_token_secret = accessTokenSecret)

# CONSUME TWITTER STREAMING API

dataPath <- paste0(trackFileName, ".json")

dataStream <- filterStream(file.name = dataPath,
                           track = trackKeyword,
                           timeout = trackTimeout,
                           oauth = oauthData)

# DATASTREAM LOADING

dataStream.df <- parseTweets(dataPath,
                             simplify = FALSE)

# DATABASE CONNECTION

mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(dataStream.df)
