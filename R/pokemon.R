library("here")
library("magrittr")
library("tidyverse")
library("ggplot2")

#  custom ggtheme, import from Github
theme_url <- 
  "https://raw.githubusercontent.com/mikedecr/theme-mgd/master/theme-mgd.R"
(source(theme_url))
theme_set(theme_mgd())

list.files("data")

pm <- read_csv(here("data/pokemon.csv")) %>%
  print()



ggplot(data = pm, aes(x = Attack,  y = Defense)) +
  geom_point(alpha = 0.3) +
  labs(title = "Pokémon Stats",
       subtitle = "Relationship between Attack and Defense Points")
  NULL

ggsave(here("handout/imgs/attack-defense.pdf"), 
       height = 3, width = 5, device = cairo_pdf)



ggplot(data = pm, aes(x = Attack,  y = Defense)) +
  geom_point(alpha = 0.3) +
  facet_wrap(~ `Type 1`) +
  scale_y_continuous(breaks = seq(0, 200, 100)) +
  scale_x_continuous(breaks = seq(0, 200, 100)) +
  labs(caption = "Panels show primary type") +
  NULL

ggsave(here("handout/imgs/attack-defense-type.pdf"), 
       height = 5, width = 6, device = cairo_pdf)

