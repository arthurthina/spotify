library(spotifyr)
library(tidyverse)
ggthemr::ggthemr("earth", type = "outer", layout = "plain", spacing = 2)

Sys.getenv("SPOTIFY_CLIENT_ID")
Sys.getenv("SPOTIFY_CLIENT_SECRET")
access_token <- get_spotify_access_token()

pearl_jam <- get_artist_audio_features('Pearl Jam') %>% 
  distinct(track_name, .keep_all = TRUE) 

glimpse(pearl_jam)

pearl_jam$album_release_date <- anytime::anytime(pearl_jam$album_release_date)
pearl_jam$album_name <- as.factor(pearl_jam$album_name)

pj_album <- pearl_jam %>% 
  group_by(album_name, album_release_date) %>% 
  select("Album" = album_name, energy, "Release" = album_release_date) %>% 
  summarise(Energy = mean(energy), .groups = "drop") %>% 
  arrange(desc(Energy))

ggplot(pj_album, aes(x = Energy, y = reorder(Album, Energy))) +
  geom_col() +
  coord_cartesian(xlim = c(.5, 1)) +
  geom_text(aes(label = Album), vjust = 0.4, hjust = 1.06,nudge_x = 0, color = "black", size = 4.5) +
  labs(x = NULL,
       y = NULL) +
  theme(axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank())
