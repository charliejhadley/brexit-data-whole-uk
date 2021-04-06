library("tidyverse")
library("sf")
library("ggtext")

brexit_results <- read_csv("data/brexit-referendum-results.csv")

uk_sf <- read_sf("data/uk_constituencies_2016")

brexit_sf <- uk_sf %>%
  left_join(brexit_results)

gg_brexit <- ggplot() +
  geom_sf(data = brexit_sf,
          aes(fill = result),
          colour = "white",
          lwd = 0.1) +
  scale_fill_manual(values = c("Leave" = "#005ea7", "Remain" = "#ffb632")) +
  theme_void(base_size = 16) +
  labs(title = "Brexit Referendum Results") +
  theme(legend.title = element_blank()) +
  labs(title = "Constituencies that voted <span style='color:#005ea7'>**Leave**</span> and <span style='color:#ffb632'>**Remain**</span> in the 2016 Brexit Referendum") +
  theme(plot.title = element_textbox_simple(minwidth = unit(5, "in"),
                                            maxwidth = unit(8, "in"))) +
  guides(fill = guide_none())

ggsave("ggplo2-brexit-map.png",
       gg_brexit)
