# LOAD LIBRARIES

library("rtweet")
library("mongolite")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)

# APP TRACKING DATA

trackKeyword <- "#DebateRedeTV"
trackFileName <- "DebateRedeTV"
trackTimeout <- 60*60*4
trackVerbose <- TRUE
trackParse <- FALSE

# APP PERSISTENCE DATA

dbName <- "debateredetv"
dbCollection <- "tweets"

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

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(dataStream.df)
