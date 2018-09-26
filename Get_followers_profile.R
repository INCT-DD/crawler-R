# LOAD LIBRARIES

library("rtweet")
library("mongolite")
library("jsonlite")


#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)
source(infos.R)


# Database with Followers ids

dbName <- ""
dbCollection <- ""

# DATABASE CONNECTION
mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)


df <- mongoConnection$find('{}')

x<-length(df$user_id)
info_followers <- lookup_users(df$user_id)

# To more than 90000 id's
#info_followers <- lookup_users(df$user_id[1:(x/2)])
#info_followers <- lookup_users(df$user_id[(x/2):x])

df_infos<- data.frame(info_followers$user_id, info_followers$screen_name, info_followers$followers_count, info_followers$friends_count, info_followers$listed_count, info_followers$statuses_count, info_followers$favourites_count, Sys.time())


dbCollection <- "infos_followers"
mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(df_infos)
