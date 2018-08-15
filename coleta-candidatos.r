library("rtweet", "readr", "mongolite", "jsonlite")

app  = ""
ckey = ""
csec = ""
atok = ""
stok = ""

twitter_token = create_token(app,ckey,csec,atok,stok)


## Informações estatísticas sobre os candidatos
candidatos <- c("33374761", "74215006", "762402774260875265", "128372940", "2670726740", 
                "105155795", "870030409890910210","256730310", "73745956", "73889361",
                "989899804200325121")

infocandidatos <- lookup_users(candidatos)
#infocandidatos <- as.matrix(infocandidatos)

#Gerando tabela com dados quantitativos de candidatos
quant_cand <- data.frame(infocandidatos$user_id, infocandidatos$screen_name, infocandidatos$followers_count, infocandidatos$friends_count, infocandidatos$friends_count, infocandidatos$statuses_count, infocandidatos$favourites_count)
#quant_cand<-as.matrix(quant_cand)

#Salvar em CSV
#write.csv(infocandidatos, file='dia1_candidatos.csv', fileEncoding = "UTF-8")
#write.csv(quant_cand, file='dia1_quant_candidatos.csv', fileEncoding = "UTF-8")

colecao<- mongo(collection = "infocandidatos", db = "infocandidatosdb")

colecao$insert(quant_cand)