context("test-dap")

test_that("data frame apply functions", {
  d <- data.frame(
    a = letters[1:5],
    b = rnorm(5),
    c = rnorm(5),
    stringsAsFactors = FALSE
  )
  ## columns
  expect_true(is.data.frame(dapc(d[-1], ~ round(.x, 3))))
  expect_true(is.data.frame(dapc(d[-1], round, 3)))
  ## rows
  expect_true(is.data.frame(dapr(d[-1], ~ round(.x, 3))))
  expect_true(is.data.frame(dapr(d[-1], round, 3)))
  ## columns IF
  expect_true(is.data.frame(dapc_if(d, is.numeric, ~ round(.x, 3))))
  expect_true(is.data.frame(dapc_if(d, is.numeric, round, 3)))
  ## rows IF
  expect_true(is.data.frame(
    dapr_if(d[-1], c(TRUE, TRUE, FALSE, FALSE, TRUE), round)))
  expect_true(is.data.frame(
    dapr_if(d[-1], ~ sum(.x) > 0, ~ round(.x, 0))))
})
