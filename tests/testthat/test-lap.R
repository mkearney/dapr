context("test-lap")

test_that("lap works", {
  d <- data.frame(
    a = letters[1:5],
    b = rnorm(5),
    c = rnorm(5),
    stringsAsFactors = FALSE
  )

  expect_true(is.list(lap(d[-1], ~ round(.x, 3))))
  expect_true(is.list(lap(d[-1], round, 3)))

  expect_true(is.data.frame(dapc(d[-1], ~ round(.x, 3))))
  expect_true(is.data.frame(dapc(d[-1], round, 3)))

  expect_true(is.data.frame(dapr(d[-1], ~ round(.x, 3))))
  expect_true(is.data.frame(dapr(d[-1], round, 3)))

  expect_true(is.data.frame(dapc_if(d, is.numeric, ~ round(.x, 3))))
  expect_true(is.data.frame(dapc_if(d, is.numeric, round, 3)))

  }
)
