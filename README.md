# README

2020-09-24

- The data are re-organized into a directory under `data`, and categorized into:
  - `data/articles.json`
  - `data/comments`
  - `data/content`


- load `tidy_data.RData` to read the following tidy data:
  - `tidy_articles`
  - `tidy_comments`
    - both dropped data before 2020-01-01
    - `kids` (comments id) are kept as lists in `tidy_articles`
  - `articles_by_day` and `articles_by_week`
  - `commnets_by_day` and `comments_by_week`