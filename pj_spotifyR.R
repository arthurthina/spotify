library(spotifyr)
library(tidyverse)

Sys.getenv("SPOTIFY_CLIENT_ID")
Sys.getenv("SPOTIFY_CLIENT_SECRET")
access_token <- get_spotify_access_token()

pearl_jam <- get_artist_audio_features('Pearl Jam') %>% 
  distinct(track_name, .keep_all = TRUE)

glimpse(pearl_jam)

pearl_jam$album_release_date <- anytime::anytime(pearl_jam$album_release_date)

pearl_jam %>% 
  count(key_name, sort = TRUE) 

