
#' Iterator list apply
#'
#' ilap: Iterate over sequence length of input and return list(s)
#'
#' @param .data Object representing the sequence length, used as ".i" in the .f
#'   expression. If matrix or data frame, sequence length will be determined by
#'   the number of columns. If integer, then it will be passed directly onto
#'   function call, otherwise the object will be converted into a sequence from
#'   1 to the length of the object.
#' @param .f Function to apply to each element (as an integer position) of input
#'   object. This can be written as a single function name e.g., \code{mean}, a
#'   formula-like function call where '.i' is assumed to be the integer position
#'   of input data object e.g., \code{~ mean(mtcars[[.i]])}, or an in-line
#'   function definition e.g., \code{function(x) mean(mtcars[[x]])}.
#' @param ... Other values passed to function call.
#' @return A list
#' @family lap
#' @examples
#'
#' ## return string list
#' ilap(1:10, ~ paste0(letters[.i], rev(LETTERS)[.i]))
#'
#' ## return list of columns
#' ilap(mtcars, ~ c(row.names(mtcars)[.i], mtcars$wt[.i]))
#'
#' @export
ilap <- function(.data, .f, ...) UseMethod("ilap")

#' @export
ilap.default <- function(.data, .f, ...) {
  if (!is.integer(.data)) {
    .data <- seq_along(.data)
  }
  if (is_lang(.f)) {
    e <- call_env()
    lapply(.data, function(.i) {
      eval(eval(.f, envir = e)[[2]], list(.i = .i), e)
    })
  } else {
    lapply(.data, .f, ...)
  }
}
