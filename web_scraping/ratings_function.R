library(tidyverse)
library(lubridate)
library(rvest)
library(xml2)
library(httr)
library(XML)
library(stringr)


# define function
user_ratings <- function(url) {

  # restaurant names vector
    restaurant <- read_html(url) %>%
    html_nodes(".list-item a+ a") %>%
    html_text2()
    
  # restaurant names links
    restaurant_links <- read_html(url) %>%
      html_nodes(".list-item a+ a") %>%
      html_attrs() %>%
      map_chr("href")
    
  # Create vectors and Loop through restaurants
    index <- 1:length(restaurant)
    users <- c()
    ratings <- c()
    restaurant_names <- c()
    
    for (i in index) {
    
      user <- read_html(restaurant_links[i]) %>%
        html_nodes(".mt-0") %>%
        html_text2() %>%
        str_extract("[aA-zZ]+")
      
      rating <- read_html(restaurant_links[i]) %>%
        html_nodes(".mt-0") %>%
        html_text2() %>%
        str_extract("[0-9]+")
      
      user_index <- 1:length(user)
      for (user_name in user_index) {
        users <- append(users,user[user_name])
        restaurant_names <- append(restaurant_names,restaurant[i])
        ratings <- as.numeric(append(ratings,rating[user_name]))
      }
    }
    
  # tibble of restaurant names and links
    df_tibble <- tibble(users, restaurant_names, ratings)
    
  # add unique id for users and restaurant names  
    df_tibble$users_id <- as.numeric(as.factor(df_tibble$users))
    df_tibble$restaurant_id <- as.numeric(as.factor(df_tibble$restaurant_names))
    df_tibble
}

