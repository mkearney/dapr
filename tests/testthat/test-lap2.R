test_that("lap2 works", {
  expect_true(
    is.list(lap2(letters, LETTERS, paste0))
  )
  expect_equal(
    lap2(letters, LETTERS, paste0)[[1]],
    "aA"
  )
  expect_true(
    is.list(lap2(letters, LETTERS, ~ paste0(.x, .y, .x, .y)))
  )
  expect_equal(
    length(lap2(letters, LETTERS, ~ paste0(.x, .y, .x, .y))),
    26L
  )
  expect_equal(
    lap2(letters, LETTERS, ~ paste0(.x, .y, .x, .y))[[1]],
    "aAaA"
  )
})
