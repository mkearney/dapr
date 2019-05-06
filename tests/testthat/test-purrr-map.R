context("map")

test_that("preserves names", {
  out <- lap(list(x = 1, y = 2), identity)
  expect_equal(names(out), c("x", "y"))
})

test_that("creates simple call", {
  out <- lap(1, function(x) sys.call())[[1]]
  expect_equal(out, quote(FUN(X[[i]], ...)))
})

test_that("fails on non-vectors", {
  expect_error(lap(environment(), identity), "is_vector.*is not TRUE")
  expect_error(lap(quote(a), identity), "is_vector.*is not TRUE")
})

test_that("0 length input gives 0 length output", {
  out1 <- lap(list(), identity)
  expect_equal(out1, list())

  out2 <- lap(NULL, identity)
  expect_equal(out2, list())
})

test_that("lap() always returns a list", {
  expect_is(lap(mtcars, mean), "list")
})

test_that("types automatically coerced upwards", {
  expect_identical(vap_int(c(FALSE, TRUE), identity), c(0L, 1L))

  expect_identical(vap_dbl(c(FALSE, TRUE), identity), c(0, 1))
  expect_identical(vap_dbl(c(1L, 2L), identity), c(1, 2))
})

test_that("logical and integer NA become correct double NA", {
  expect_identical(
    vap_dbl(list(NA, NA_integer_), identity),
    c(NA_real_, NA_real_)
  )
})

test_that("map forces arguments in same way as base R", {
  f_map <- lap(1:2, function(i) function(x) x + i)
  f_base <- lapply(1:2, function(i) function(x) x + i)

  expect_equal(f_map[[1]](0), f_base[[1]](0))
  expect_equal(f_map[[2]](0), f_base[[2]](0))
})

test_that("map works with calls and pairlists", {
  out <- lap(quote(f(x)), ~ quote(z))
  expect_equal(out, list(quote(z), quote(z)))

  out <- lap(pairlist(1, 2), ~ .x + 1)
  expect_equal(out, list(2, 3))
})



context("imap")

x <- setNames(1:3, 1:3)

test_that("imap is special case of map2", {
  expect_identical(ilap(x, paste), Map(paste, x))
})

test_that("imap always returns a list", {
  expect_is(ilap(x, paste), "list")
})

#test_that("atomic vector imap works", {
  #expect_true(all(imap_lgl(x, `==`)))
  #expect_length(imap_chr(x, paste), 3)
  #expect_equal(imap_int(x, ~ .x + as.integer(.y)), x * 2)
  #expect_equal(imap_dbl(x, ~ .x + as.numeric(.y)), x * 2)
  #expect_equal(imap_raw(as.raw(12), rawShift), rawShift(as.raw(12), 1) )
#})

#test_that("data frame imap works", {
#  expect_identical(imap_dfc(x, paste), imap_dfr(x, paste))
#})

