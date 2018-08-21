library(twitteR)
library(mongolite)

appName <- ""
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
mongoPort <- 27017

# APP PERSISTENCE DATA

dbName <- "friendslistdb"
dbCollection <- "friendslist"


#candidate profile
profile <- c( "geraldoalckmin", "jairbolsonaro", "LulaOficial", "Haddad_Fernando","MarinaSilva", "joaoamoedonovo","alvarodias_", "Eymaeloficial")
                    
#DataFrame 
df<-data.frame()

#Tracking data
for (p in profile){
    print(paste('Coletando informações sobre @',p,'...'))
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

mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)


mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(df)