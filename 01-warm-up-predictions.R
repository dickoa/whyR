if (!require(pacman)) install.packages("pacman")

pacman::p_load("tidyverse", "lubridate", "forecast", "hrbrthemes",
               "patchwork")

p_a <- ggplot(tidy_data, aes(x=time, y=a_num)) +
  geom_line(color="steelblue") +
  geom_point(alpha=0.8, size=0.5) +
  xlab("") +
  ylab("Number of articles") +
  ggtitle("Time series of daily new articles in 2020") +
  theme_ipsum_rc() +
  theme(axis.text.x=element_text(angle=30, hjust=1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  # limit=c(as_date("2020-01-01"),as_date("2020-09-30"))) +
  ylim(0, max(tidy_data$a_num) + 10)

recent_tidy_data <- tidy_data %>%
  filter(time>=as_date("2020-08-14"))
p_c <- ggplot(recent_tidy_data, aes(x=time, y=c_num)) +
  geom_line(color="seagreen") +
  geom_point(alpha=0.8, size=0.5) +
  xlab("") +
  ylab("Number of comments") +
  ggtitle("Time series of recent daily new comments") +
  theme_ipsum_rc() +
  theme(axis.text.x=element_text(angle=30, hjust=1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 week") +
  # limit=c(as_date("2020-01-01"),as_date("2020-09-30"))) +
  ylim(0, max(tidy_data$c_num) + 10)

p_s <- ggplot(tidy_data, aes(x=time, y=score)) +
  geom_line(color="coral") +
  geom_point(alpha=0.8, size=0.5) +
  xlab("") +
  ylab("Top score of articles") +
  ggtitle("Time series of daily top score articles in 2020") +
  theme_ipsum_rc() +
  theme(axis.text.x=element_text(angle=30, hjust=1)) +
  scale_x_date(date_labels = "%b %d", date_breaks = "1 month") +
  # limit=c(as_date("2020-01-01"),as_date("2020-09-30"))) +
  ylim(0, max(tidy_data$score) + 50)

p_a / p_s / p_c

# --------------------------------------------------------------------
# do time series analysis on:
# 1. the number of posts
# 2. the number of comments
# 3. the `max(score)` within a day

# 1.1 predict the number of posts