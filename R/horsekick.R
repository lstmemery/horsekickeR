#' Removes and Warns if Horse Kick Data Malformed
#'
#' The model needs a year range between 1701-1919.
#' The model is only aware of I-XV and G corps.
#'
#' @param horse_kick_df A dataframe with at least two columns: year and corps
#'
#' @return A dataframe with two columns: year and corps and only valid rows
#' @export
#'
#' importFrom rlang .data
clean_horse_kicks <- function(horse_kick_df) {

  prussian_corps <- c("G", "I", "II", "III", "IV", "V", "VI",
                      "VII", "VIII", "IX", "X", "XI", "XIV", "XV")

  horse_kick_df %>%
    assertr::verify(
      assertr::has_all_names("year", "corps") ,
      error_fun = assertr::error_stop) %>%
    assertr::assert(
      assertr::within_bounds(1701, 1919, allow.na = FALSE), # Period of the Prussian Armies existence
      .data$year,
      error_fun = assertr::warn_report) %>%
    assertr::assert(
      assertr::in_set(prussian_corps, allow.na = FALSE), # Only include known Corps
      .data$corps,
      error_fun = assertr::warn_report) %>%
    dplyr::select(.data$year, .data$corps) %>%
    dplyr::filter(dplyr::between(.data$year, 1701, 1919),
                  .data$corps %in% prussian_corps)
}

predict_horse_kicks <- function(clean_kick_df) {
  model <- readRDS(
    system.file("extdata", "horse_kick_glm.0.1.0.rds",
                package = "horsekickR"),
  )

  predict(model, clean_kick_df)
}
