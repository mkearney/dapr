context("test-vap")

test_that("vector apply functions", {
  set.seed(12)
  d <- replicate(5, rnorm(10), simplify = FALSE)
  e <- replicate(5, sample(letters, 10), simplify = FALSE)
  ## numeric
  expect_true(is.numeric(vap_dbl(e, ~ sum(nchar(.x)))))
  expect_true(is.numeric(vap_dbl(d, sum)))
  ## character
  expect_true(is.character(vap_chr(e, ~ paste(.x, collapse = ""))))
  expect_true(is.character(vap_chr(e, paste, collapse = "")))
  ## logical
  expect_true(is.logical(vap_lgl(d, ~ max(.x) > 3)))
  ## integer
  expect_true(is.integer(vap_int(d, length)))
})
