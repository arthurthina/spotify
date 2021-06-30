library(tidyverse)
library(lubridate)

df_spot <- read_csv("/mnt/sda5/git/spotify/data/tracks.csv")

str(df_spot)

 df_spot <- df_spot %>% 
  mutate(duration_ms = hms::as_hms(duration_ms / 1000))
 
pj_songs <- df_spot %>% filter(str_detect(artists, pattern = "Pearl Jam") & energy > 0.3) %>% 
  arrange(desc(energy))

ggplot(df_spot, aes(x = duration_ms, y = energy)) +
  geom_point()
