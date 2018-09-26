# LOAD LIBRARIES

library("rtweet")
library("mongolite")


#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)
source(infos.R)


# APP PERSISTENCE DATA

dbName <- ""
dbCollection <- ""

# Statistical information on candidates
info_candidates <- lookup_users(candidates_ids)
quant_cand <- data.frame(info_candidates$user_id, info_candidates$screen_name, info_candidates$followers_count, info_candidates$friends_count, info_candidates$listed_count, info_candidates$statuses_count, info_candidates$favourites_count, Sys.time())

# Statistical information on political party

info_political_party <- lookup_users(political_parties_ids)
quant_part <- data.frame(info_political_party$user_id, info_political_party$screen_name, info_political_party$followers_count, 
                         info_political_party$friends_count, info_political_party$listed_count, info_political_party$statuses_count,
                         info_political_party$favourites_count, Sys.time())



# DATABASE CONNECTION

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(quant_part)
