source("ratings_function.R")
library(tidyverse)

# url string of page to scrape
url <- "https://www.top-rated.online/countries/Papua+New+Guinea/cities/Port+Moresby/Restaurants/top-rated"

# scrape website
df <- user_ratings(url)

# Adjust tibble columns
df <- df %>% dplyr::select(4,2,5,3)

# Create id's df
df_id <- df %>% dplyr::select(4,5,3)

# save df's as csv
write_csv(df,"raw.csv")
write_csv(df_id,"raw_ids.csv")




