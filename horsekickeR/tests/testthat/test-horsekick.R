context("test-horsekick")

test_that("clean_horse_kicks removes bad entries", {
  test_df <- dplyr::tibble(
    year = c(1492, 1848, 2019, 1871),
    corps = c("I", "I", "I", "XXIII")
  )

  reference_df <- dplyr::tibble(
    year = c(1848),
    corps = c("I")
  )

  expect_equal(
    expect_warning(clean_horse_kicks(test_df)),
    reference_df
  )

})
