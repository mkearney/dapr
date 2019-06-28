context("test-vap")

test_that("vector apply functions", {
  ## generate data
  set.seed(12)
  d <- replicate(5, rnorm(10), simplify = FALSE)
  e <- replicate(5, sample(letters, 10), simplify = FALSE)
  m <- matrix(rnorm(25), 5)

  ##--------------------------------------------------------------------------##
  ##                                     DBL                                  ##
  ##--------------------------------------------------------------------------##

  ## standard
  expect_true(is.numeric(vap_dbl(e, ~ sum(nchar(.x)))))
  expect_true(is.numeric(vap_dbl(d, sum)))

  ## by row/column
  expect_true(is.numeric(vapr_dbl(m, ~ sum(nchar(.x)))))
  expect_true(is.numeric(vapr_dbl(m, sum)))
  expect_equal(length(vapr_dbl(m, sum)), nrow(m))
  expect_true(is.numeric(vapc_dbl(m, ~ sum(nchar(.x)))))
  expect_true(is.numeric(vapc_dbl(m, sum)))
  expect_equal(length(vapc_dbl(m, sum)), ncol(m))

  ##--------------------------------------------------------------------------##
  ##                                     CHR                                  ##
  ##--------------------------------------------------------------------------##

  ## standard
  expect_true(is.character(vap_chr(e, ~ paste(.x, collapse = ""))))
  expect_true(is.character(vap_chr(e, paste, collapse = "")))

  ## by row/column
  expect_true(is.character(vapr_chr(m, ~ paste(.x, collapse = ""))))
  expect_true(is.character(vapc_chr(m, paste, collapse = "")))
  expect_equal(length(vapc_chr(m, paste, collapse = "")), ncol(m))

  ##--------------------------------------------------------------------------##
  ##                                     LGL                                  ##
  ##--------------------------------------------------------------------------##

  ## standard
  expect_true(is.logical(vap_lgl(d, ~ max(.x) > 3)))

  ## by row/column
  expect_true(is.logical(vapr_lgl(m, ~ max(.x) > 3)))
  expect_true(is.logical(vapc_lgl(m, ~ max(.x) > 3)))
  expect_equal(length(vapr_lgl(m, ~ max(.x) > 3)), nrow(m))

  ##--------------------------------------------------------------------------##
  ##                                     INT                                  ##
  ##--------------------------------------------------------------------------##

  ## standard
  expect_true(is.integer(vap_int(d, length)))

  ## by row/column
  expect_true(is.integer(vapr_int(m, length)))
  expect_true(is.integer(vapc_int(m, length)))
  expect_equal(length(vapc_int(m, length)), ncol(m))
})
