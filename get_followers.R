library("rtweet")
library("mongolite")

# Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source('config.R')

# Get followers
args <- commandArgs(trailingOnly=TRUE)
profile <- args[1]
followers <- as.numeric(args[2])

# APP PERSISTENCE DATA

dbName <- paste0(args[3], "db")
dbCollection <-args[3]


f<-data.frame()
for(i in 1:(ceiling(followers/75000))){ 
    f1 <- get_followers(profile, n = 75000)
    page <- next_cursor(f1)
    Sys.sleep(15 * 60) 
    f2 <- get_followers(profile, n = 75000, page = page)
    f <- do.call("rbind", list(f1, f2))
}
#nrow(f)

# DATABASE CONNECTION

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection)
                         #url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(f)
