if (!require(pacman)) install.packages("pacman")
pacman::p_load("tidyverse", "jsonlite", "tidyjson", "tidyr")

articles <- fromJSON(readLines('data/articles.json'))
# glimpse(articles)
comments <- fromJSON(readLines('data/comments/comments_recent.json'))
# glimpse(comments)

tidy_articles <- tibble(
  by = unlist(articles$by),
  descendants = unlist(articles$descendants),
  id = unlist(articles$id),
  # comment_count <- lengths(articles$kids),
  kids = articles$kids,
  score = unlist(articles$score),
  time = unlist(articles$time),
  title = unlist(articles$title),
  type = unlist(articles$type),
  url = sapply(articles$url, function(X) if (length(X) == 0) NA_character_ 
               else paste(X, collapse = " "))
) %>%
  mutate(time = parse_datetime(time)) %>%
  filter(time >= as.Date("2020-01-01"))

tidy_comments <- as_tibble(comments) %>%
  mutate(time = parse_datetime(time)) %>%
  drop_na() %>%
  filter(time >= as.Date("2020-01-01"))

articles_by_day <- tidy_articles %>%
  group_by(date=lubridate::floor_date(time, "day")) %>%
  summarize(amount=n())
articles_by_week <- tidy_articles %>%
  group_by(date=lubridate::floor_date(time, "week")) %>%
  summarize(amount=n())
comments_by_day <- tidy_comments %>%
  group_by(date=lubridate::floor_date(time, "day")) %>%
  summarize(amount=n())
comments_by_week <- tidy_comments %>%
  group_by(date=lubridate::floor_date(time, "week")) %>%
  summarize(amount=n())

# --------------------------------------------------------------------
save(tidy_articles, tidy_comments,
     articles_by_day, articles_by_week,
     comments_by_day, comments_by_week,
     file = "tidy_data.RData")
# --------------------------------------------------------------------

# do time series analysis on:
# 1. the number of posts
# 2. the number of comments, which should be the count of `kids` variable
# 3. the `max(score)` within a day

# CLEANING!
# rm(list = ls())
# gc()
