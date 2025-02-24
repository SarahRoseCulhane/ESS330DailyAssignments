#Sarah Culhane, 2/24/25, daily assignment 7
library(tidyverse)
covid <- read_csv('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties-recent.csv')

df_new <- data.frame(region = state.region,
                 abbr = state.abb,
                 state = state.name) 

inner_join(df_new, covid, by = "state") |>
  group_by(region, date) |>
  summarize(cases = sum(cases),
            deaths = sum(deaths)) |>
  pivot_longer(cols = c(cases, deaths),
               names_to = "type",
               values_to = "count") |>
  ggplot(aes(x = date, y = count)) +
  geom_line() +
  facet_grid(type~region, scales = "free_y")+
  theme_bw()

