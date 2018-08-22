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

# APP PERSISTENCE DATA

dbName <- "estatisticas"
dbCollection <- "candidatos"


# PERFORM TWITTER AUTH

oauthData <- create_token(app = appName,
                          consumer_key = consumerKey,
                          consumer_secret = consumerSecret,
                          access_token = accessToken,
                          access_secret = accessTokenSecret)


# List of candidates
candidates <- c("33374761", "74215006", "762402774260875265", "128372940", 
                "2670726740","105155795", "870030409890910210","256730310", 
                "73745956", "73889361","989899804200325121", "354095556")

# Statistical information on candidates
info_candidates <- lookup_users(candidates)
quant_cand <- data.frame(info_candidates$user_id, info_candidates$screen_name, info_candidates$followers_count, info_candidates$friends_count, info_candidates$listed_count, info_candidates$statuses_count, info_candidates$favourites_count, Sys.time())

# Statistical information on political party

political_party <- c("180500907", "39931528","1202130601","1011297899463041028",
              "39522911","1151011908","86320511","2734700584","868487844595212288",
              "83835435","26250547","73144615")

info_political_party <- lookup_users(political_party)
quant_part <- data.frame(info_political_party$user_id, info_political_party$screen_name, info_political_party$followers_count, 
                         info_political_party$friends_count, info_political_party$listed_count, info_political_party$statuses_count,
                         info_political_party$favourites_count, Sys.time())



# DATABASE CONNECTION

mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)


mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(quant_part)