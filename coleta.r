## Lista de pacotes que ser�o usados
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

cole��o<- mongo(collection = "cole��o_lula", db = "lulapresohoje") # create connection, database and collection
cole��o$insert(dados)

cole��o$count('{"source" : "Twitter Web Client","is_retweet" : "false" }')