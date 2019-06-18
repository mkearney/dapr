#' lap: List apply functions
#'
#' Function(s) that apply expressions to input data objects and return lists.
#'
#' @name lap
#' @seealso \code{\link{dap}} \code{\link{vap}}
NULL

#' List apply
#'
#' lap: Iterate over input and return list(s)
#'
#' @param .data Input object–numeric, character, list, data frame, etc.–over
#'   which elements will be iterated. If matrix or data frame, each
#'   column will be treated as the elements which are to be iterated over.
#' @param .f Function to apply to each element of input object. This can be
#'   written as a single function name e.g., \code{mean}, a formula-like
#'   function call where '.x' is assumed to be the iterated over element of
#'   input data e.g., \code{~ mean(.x)}, or an in-line function definition e.g.,
#'   \code{function(x) mean(x)}.
#' @param ... Other values passed to function call.
#' @return A list
#' @family lap
#' @examples
#'
#' ## return string list
#' lap(letters, ~ paste0(.x, "."))
#'
#' ## return list of columns
#' lap(mtcars[1:5, ], as.character)
#'
#' ## map over two vectors
#' lap2(letters, LETTERS, ~ paste0(.x, .y, .x, .y))
#'
#' @export
lap <- function(.data, .f, ...) UseMethod("lap")

#' @export
lap.default <- function(.data, .f, ...) {
  assert_that(is_vector(.data))

  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    lapply(.data, function(.x) {
      eval(.f, list(.x = .x), e)
    })
  } else {
    lapply(.data, .f, ...)
  }
}

#' @rdname lap
#' @inheritParams lap
#' @param .x First data vector input (for lap2)
#' @param .y Second data vector input (for lap2)
#' @export
lap2 <- function(.x, .y, .f, ...) UseMethod("lap2")

#' @export
lap2.default <- function(.x, .y, .f, ...) {
  assert_that(is_vector(.x))
  assert_that(is_vector(.y))
  assert_that(length(.x) == length(.y))

  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    # .f <- as.call(.f)
    # tfse::cat_line(class(.f))
    # tfse::cat_line(deparse(.f))
    # mapply(
    #   .f, .x, .y, SIMPLIFY = FALSE
    # )
    lapply(seq_along(.x), function(.i) {
      eval(.f, list(.x = .x[[.i]], .y = .y[[.i]]), e)
    })
  } else {
    mapply(.f, .x, .y, ..., SIMPLIFY = FALSE)
  }
}
