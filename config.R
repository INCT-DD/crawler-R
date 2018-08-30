<<<<<<< Updated upstream
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

# SET SEARCH PARAMETERS (referTo: https://github.com/twintproject/twint/wiki/Module)

searchParameters.Username <- ""
searchParameters.Output <- ""
searchParameters.Stats <- TRUE
searchParameters.Store_json <- TRUE
searchParameters.Profile_full <- TRUE
=======
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
>>>>>>> Stashed changes
