# LOAD LIBRARIES

library("rtweet")
library("mongolite")

# TWITTER AUTH DATA

appName <- ""
consumerKey <- ""
consumerSecret <- ""
accessToken <- ""
accessTokenSecret <- ""

# MONGODB AUTH DATA

mongoUser <- ""
mongoPasswd <- ""
mongoHost <- "127.0.0.1"
mongoPort <- 27017

# APP TRACKING DATA

trackKeyword <- "#DebateRedeTV"
trackFileName <- "DebateRedeTV"
trackTimeout <- 60*60*4
trackVerbose <- TRUE
trackParse <- FALSE

# APP PERSISTENCE DATA

dbName <- "debateredetv"
dbCollection <- "tweets"

# PERFORM TWITTER AUTH

oauthData <- create_token(app = appName,
                          consumer_key = consumerKey,
                          consumer_secret = consumerSecret,
                          access_token = accessToken,
                          access_secret = accessTokenSecret)

# CONSUME TWITTER STREAMING API

dataStream <- stream_tweets(q = trackKeyword,
                            timeout = trackTimeout,
                            file_name = trackFileName,
                            token = oauthData,
                            verbose = trackVerbose,
                            parse = trackParse)

# DATASTREAM LOADING

dataPath <- paste0(trackFileName, ".json")

dataStream.df <- parse_stream(dataPath)

print(dataStream)

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