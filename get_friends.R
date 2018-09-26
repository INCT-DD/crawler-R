# LOAD LIBRARIES

library("rtweet")
library("mongolite")


#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)
source(infos.R)


# APP PERSISTENCE DATA

dbName <- "friendslistdb"
dbCollection <- "friendslist"

df<-data.frame()
for (p in candidates_ids){
  
  #Tracking data of friends
  p<- lookup_users(p)
  id_friends<- get_friends(p$user_id, retryonratelimit = FALSE)
  friends_list<- c()
  
  for (i in id_friends){
    friend= lookup_users(i)
    friends_list <- append(x=friends_list,values=friend$screen_name)
  }
  
  df<-rbind(df,cbind(p$screen_name, friends_list))
}

colnames(df) <-c('Source', 'Target')

# DATABASE CONNECTION
mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(df)
