# pull data from twitter

library(tidyverse)
library(lubridate)
library(rtweet)

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
  select(text, created_at) %>%
  mutate(local_time = with_tz(created_at, tzone= "America/Los_Angeles")) %>% 
  mutate(date = as.Date(local_time)) %>% 
  mutate(time_of_day = get_time(local_time)) %>%
  mutate(commute = cut(x=hour(local_time), breaks = breaks, labels = labels, include.lowest=TRUE, right=F)) %>% 
  select(text, local_time, commute, date, time_of_day)
write_csv(tweets, "Data/caltrain_tweets.csv")