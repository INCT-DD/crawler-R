library("twitteR")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)

# PERFORM TWITTER AUTH
oauthData2 <- setup_twitter_oauth(consumer_key = consumerKey,
                                  consumer_secret = consumerSecret,
                                  access_token = accessToken,
                                  access_secret = accessTokenSecret)

userName = ""

##fetch tweets from @userName timeline

tweets = userTimeline(userName,n = 1)

## converting tweets list to DataFrame  
tweets <- twListToDF(tweets)  

## building queryString to fetch retweets 
queryString = paste0("to:",userName)

## retrieving tweet ID for which reply is to be fetched 
Id = tweets[1,"id"]  

## fetching all the reply to userName
rply = searchTwitter(queryString, sinceID = Id) 
rply = twListToDF(rply)

## eliminate all the reply other then reply to required tweet Id  
rply = rply[!rply$replyToSID > Id,]
rply = rply[!rply$replyToSID < Id,]
rply = rply[complete.cases(rply[,"replyToSID"]),]