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
  mutate(time = parse_datetime(time))

tidy_comments <- as_tibble(comments) %>%
  mutate(time = parse_datetime(time)) %>%
  drop_na()

save(tidy_articles, tidy_comments, file = "tidy_data.RData")
rm(articles, comments)



# --------------------------------------------------------------------

# do time series analysis on:
# 1. the number of posts
# 2. the number of comments, which should be the count of `kids` variable
# 3. the `max(score)` within a day

# CLEANING!
# rm(list = ls())
# gc()
