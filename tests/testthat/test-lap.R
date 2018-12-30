context("test-lap")

test_that("list apply functions", {
  d <- data.frame(
    a = letters[1:5],
    b = rnorm(5),
    c = rnorm(5),
    stringsAsFactors = FALSE
  )
  expect_true(is.list(lap(d[-1], ~ round(.x, 3))))
  expect_true(is.list(lap(d[-1], round, 3)))
  min <- 3
  expect_true(is.list(lap(d[-1], ~ round(.x, min))))
  expect_true(is.list(lap(d[-1], round, digits = 3)))

  expect_true(is.list(ilap(1:10, ~ paste0(letters[.i], rev(LETTERS)[.i]))))
  expect_equal(nchar(ilap(1:10, ~ paste0(letters[.i], rev(LETTERS)[.i]))[[1]]), 2)
})
