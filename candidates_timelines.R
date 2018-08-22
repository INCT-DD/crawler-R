# LOAD LIBRARIES

library("rtweet")
library("mongolite")
library("dplyr")

# TWITTER AUTH DATA

appName <- ""
consumerKey <- ""
consumerSecret <- ""
accessToken <- ""
accessTokenSecret <- ""

# MONGODB AUTH DATA

mongoUser <- ""
mongoPasswd <- ""
mongoHost <- "127.0.0.1"
mongoPort <- 27017

# APP PERSISTENCE DATA

dbName <- "timelinesdb"
dbCollection <- "timelines"


candidates <- c("33374761", "74215006", "762402774260875265", "128372940", "2670726740", 
                "105155795", "870030409890910210","256730310", "73745956", "73889361",
                "989899804200325121")

# Statistical information
infocand <- lookup_users(candidates)

# Timelines
timelines<-get_timelines(candidates, n=3200)
c <- as.matrix(timelines)
write.csv(c,'timelines.csv')

# Chart plotting

timelines %>%
  dplyr::filter(created_at > "2017-10-29") %>%
  dplyr::group_by(screen_name) %>%
  ts_plot("days", trim = 1L) +
  ggplot2::geom_point() +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequência de tweets publicados por candidatos às eleições 2018",
    subtitle = "Número de publicações por mês",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# DATABASE CONNECTION

mongoUrl <- URLencode(paste0("mongodb://",
                             mongoUser, ":", mongoPasswd,
                             "@", mongoHost, ":", mongoPort)
)

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(timelines)
