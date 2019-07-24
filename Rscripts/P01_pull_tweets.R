# pull data from twitter

library(tidyverse)
library(lubridate)
library(rtweet)
library(data.table)


d <- get_timeline('@Caltrain', n= 3200, include_rts = FALSE) 

get_time <- function(time = now()) {
  time %>%
    str_split(" ") %>%
    map_chr(2) %>%
    hms()
}

# define commute times
breaks <- hour(hm("00:00", "7:00", "9:00", "15:00", "19:00", "23:59"))
labels <- c("Other", "Morning", "Other", "Evening", "Other")

tweets <- d %>% 
  filter(is.na(reply_to_status_id))  %>% 
  dplyr::select(text, created_at) %>%
  mutate(local_time = with_tz(created_at, tzone= "America/Los_Angeles")) %>% 
  mutate(date = as.Date(local_time)) %>% 
  mutate(time_of_day = strftime(local_time, format="%H:%M:%S")) %>%
  mutate(commute = cut(x=hour(local_time), breaks = breaks, labels = labels, include.lowest=TRUE, right=F)) %>% 
  dplyr::select(text, local_time, commute, date, time_of_day)
# write_csv(tweets, "Data/caltrain_tweets.csv") # original pull

# future pulls should add on
old <- read_csv("Data/caltrain_tweets.csv") %>% 
  mutate(time_of_day = strftime(local_time, format="%H:%M:%S"))

new <- old %>% 
  bind_rows(tweets) %>% 
  distinct()
write_csv(new, "Data/caltrain_tweets_new.csv") 
