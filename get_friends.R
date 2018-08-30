library(twitteR)
library(mongolite)

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)
source(infos.R)

# APP PERSISTENCE DATA

dbName <- "friendslistdb"
dbCollection <- "friendslist"
                    
#DataFrame 
df<-data.frame()

#Tracking data
for (p in profile){
    print(paste('Coletando informacoes sobre @',p,'...'))
    profile <- getUser(p)
          
    #Tracking data of friends
    id_friends<- profile$getFriends(retryOnRateLimit=120)
    friends_list<- c()
    
    for (i in id_friends){
      friends_list <- append(x=friends_list,values=i$screenName)
    }
            
    df<-rbind(df,cbind(profile$screenName, friends_list))
}
                    
colnames(df) <-c('Source', 'Target')

#Save as csv

write.csv(df,'redeamigos_candidatos.csv')

# DATABASE CONNECTION
mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(df)
