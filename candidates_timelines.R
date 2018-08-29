# LOAD LIBRARIES

library("rtweet")
library("mongolite")
library("dplyr")

#Inform which directory is the file.(source('~/git/crawler-R/infos.R'))
source(infos.R)
source(config.R)


# APP PERSISTENCE DATA

dbName <- "timelinesdb"
dbCollection <- "timelines"


# Statistical information
infocand <- lookup_users(candidates_ids)

# Timelines
timelines<-get_timelines(candidates_ids, n=3200)
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
    title = "Frequencia de tweets publicados por candidatos nas eleicoes 2018",
    subtitle = "Numero de publicacoes por mes",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )


# DATABASE CONNECTION

mongoConnection <- mongo(db = dbName,
                         collection = dbCollection,
                         url = mongoUrl)

# DATA PERSISTENCE TO DATABASE

mongoConnection$insert(timelines)
