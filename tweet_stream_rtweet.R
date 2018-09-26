# LOAD LIBRARIES

library("rtweet")
library("mongolite")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config)

# APP TRACKING DATA

args <- commandArgs(trailingOnly=TRUE)

trackKeyword <- args[1]
trackFileName <- args[1]
trackTimeout <- as.numeric(args[2])
print(trackTimeout)
trackVerbose <- TRUE
trackParse <- TRUE


# APP PERSISTENCE DATA

dbName <- paste0(args[3], "db")
dbCollection <- args[3]

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



# DATABASE CONNECTION

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(dataStream.df)
