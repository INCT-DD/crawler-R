## Lista de pacotes que serão usados
library("rtweet", "mongolite", "readr") 

app  = ""
ckey = ""
csec = ""
atok = ""
stok = ""

twitter_token = create_token(app, ckey, csec,atok,stok)

stream_tweets(q="LulaLivre",timeout = 300, parse = FALSE, file_name="tweets10", token=twitter_token)

dados <- parse_stream("tweets10.json")

#Enviando dados para mongodb

coleção<- mongo(collection = "coleção_lula", db = "lulapresohoje") # create connection, database and collection
coleção$insert(dados)

coleção$count('{"source" : "Twitter Web Client","is_retweet" : "false" }')