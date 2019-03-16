library(dplyr)

#* Predict the number of horse kick deaths a soldier suffered in a year
#*
#* @json
#* @post /predict
predict <- function(req) {

  horse_kick_df <- jsonlite::fromJSON(req$postBody) %>%
    as_tibble()

  results <- horse_kick_df %>%
    clean_horse_kicks() %>%
    predict_horse_kicks()

  jsonlite::toJSON(results, dataframe = "columns")
}
