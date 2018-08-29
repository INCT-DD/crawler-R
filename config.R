# TWITTER AUTH DATA

consumerKey <- ""
consumerSecret <- ""
accessToken <- ""
accessTokenSecret <- ""

# PERFORM TWITTER AUTH

oauthData <- setup_twitter_oauth(consumer_key = consumerKey,
                                 consumer_secret = consumerSecret,
                                 access_token = accessToken,
                                 access_secret = accessTokenSecret)

# MONGODB AUTH DATA

mongoUser <- ""  
mongoPasswd <- ""
mongoHost <- "127.0.0.1"
mongoPort <- "27017"


# APP PERSISTENCE DATA

dbName <- "testedb"
dbCollection <- "tweets"


# DATABASE CONNECTION

mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)