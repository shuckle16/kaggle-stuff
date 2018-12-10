library(tidyverse)
library(skimr)

avocado <- 
  read_csv("avocado.csv") %>% 
  rename_all(tolower)

# summary stats ----
skimr::skim(avocado)

avocado %>% 
  group_by(
    region, type
  ) %>% 
  summarize(
    mean_price = mean(averageprice),
    sd_price = sd(averageprice)
  ) %>% 
  arrange(
    desc(mean_price)
  )

# plots ----
# prices over time
ggplot(avocado, 
       aes(x = date, y = averageprice)) + 
  geom_line(aes(color = type)) + 
  facet_wrap(~region)


# elasticities by region
# need to filter out meta regions
ggplot(avocado, 
       aes(x = averageprice, y = `total volume`)) + 
  geom_point(aes(color = type), alpha = .3) + 
  geom_smooth(aes(group = region), method = "lm") + 
  facet_wrap(~type, scales = "free") + 
  scale_y_log10()

