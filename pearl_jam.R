library(tidyverse)
library(lubridate)
library(ggthemr)

df_spot <- read_csv("data/tracks.csv")

str(df_spot)

 df_spot <- df_spot %>% 
  mutate(duration_ms = hms::as_hms(duration_ms / 1000))

 
pj_songs <- df_spot %>% filter(str_detect(artists, pattern = "Pearl Jam") &
                              !str_detect(artists, pattern = "Hill")) %>% 
  top_n(10, energy)

str(pj_songs)

ggthemr("earth", type = "outer", layout = "plain", spacing = 2)
ggplot(pj_songs, aes(x = energy, y = reorder(name, energy), fill = release_date)) +
  geom_col() +
  coord_cartesian(xlim = c(0.920, 1)) +
  labs( title = "Top 10 Músicas mais 'Energéticas' do Pearl Jam",
        subtitle = "De acordo com o Spotify",
        caption = "Dados extraídos em 2021-07-02",
        fill = "Data de Lançamento",
        x = "Energia", 
        y = "Nome da Música") +
  theme(plot.title = element_text(size = 20, face = "bold"),
        plot.subtitle = element_text(size = 15),
        plot.caption = element_text(hjust = 1),
        axis.text = element_text(size = 12),
        axis.title.y = element_text(size = 16, face = "bold"),
        axis.title.x = element_text(size = 16, face = "bold"))

  