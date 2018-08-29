library("rtweet")
library("mongolite")

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

# APP PERSISTENCE DATA

dbName <- "followerslistdb"
dbCollection <- "followerslist"


# PERFORM TWITTER AUTH

oauthData <- setup_twitter_oauth(consumer_key = consumerKey,
                                 consumer_secret = consumerSecret,
                                 access_token = accessToken,
                                 access_secret = accessTokenSecret)


#Get followers

f1 <- get_followers("lulaoficial", n = 75000)
page <- next_cursor(f1)
Sys.sleep(15 * 60) 
f2 <- get_followers("lulaoficial", n = 75000, page = page)
f <- do.call("rbind", list(f1, f2))
nrow(f)

# DATABASE CONNECTION

mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)


mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(f)
