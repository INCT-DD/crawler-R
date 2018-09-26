# LOAD LIBRARIES

library("rtweet")
library("mongolite")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(config.R)
source(infos.R)

# APP PERSISTENCE DATA

dbName <- "timelinesdb"
dbCollection <- "timelines"


#Argumentos
args <- commandArgs(trailingOnly=TRUE)
candidates <- args[1]

# Timelines
timelines<-get_timelines(candidates, n=3200)

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
    title = "Frequ?ncia de tweets publicados por candidatos ?s elei??es 2018",
    subtitle = "N?mero de publica??es por m?s",
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