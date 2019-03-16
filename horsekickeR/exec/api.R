library(dplyr)

#* Predict the number of horse kick deaths a soldier suffered in a year
#*
#* @json
#* @post /predict
predict <- function(req) {

  print("Start")

  horse_kick_df <- jsonlite::fromJSON(req$postBody) %>%
    as_tibble()

  print(horse_kick_df)

  results <- horse_kick_df %>%
    clean_horse_kicks() %>%
    predict_horse_kicks()

  print(results)

  jsonlite::toJSON(results, dataframe = "columns")
}
