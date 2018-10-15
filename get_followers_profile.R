# LOAD LIBRARIES

library("rtweet")
library("mongolite")
#library("jsonlite")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source('config.R')
source('infos.R')


# APP PERSISTENCE DATA
args <- commandArgs(trailingOnly=TRUE)
dbName <- args[1]
dbCollection <- args[2]

# DATABASE CONNECTION
mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)


# Leitura dos ids dos seguidores que estao na base
df <- mongoConnection$find('{}')
q<-length(df$user_id)
x<-(ceiling(q/90000))
info_followers<-data.frame()

# Para preencher o vetor de intervalos
vet <- c(1)

for(i in 1:x){ 
  count <- 90000 * i
  vet[i+1] <- count
}

# Coleta dos dados dos followers de um profile
for(i in 1:x){ 
  if(i == 1){
    info_followers <- lookup_users(df$user_id[(vet[i]):vet[i+1]])
    df_infos<- data.frame(info_followers$user_id, info_followers$screen_name, info_followers$followers_count, info_followers$friends_count, info_followers$listed_count, info_followers$statuses_count, info_followers$favourites_count, Sys.time())
  } else {
    info_followers <- lookup_users(df$user_id[(vet[i]+1):vet[i+1]])
    df_infos<- data.frame(info_followers$user_id, info_followers$screen_name, info_followers$followers_count, info_followers$friends_count, info_followers$listed_count, info_followers$statuses_count, info_followers$favourites_count, Sys.time())
  }
  Sys.sleep(15 * 60) 
}

dbCollection <- "infos_followers"
mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(df_infos)
