library("rtweet")
library("mongolite")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)
source(infos.R)

# APP PERSISTENCE DATA

dbName <- "followerslistdb"
dbCollection <- "followerslist"

#Get followers
args <- commandArgs(trailingOnly=TRUE)
profile <- args[1]

f1 <- get_followers(profile, n = 75000)
page <- next_cursor(f1)
Sys.sleep(15 * 60) 
f2 <- get_followers(profile, n = 75000, page = page)
f <- do.call("rbind", list(f1, f2))
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