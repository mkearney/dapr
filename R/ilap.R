
#' Iterator list apply
#'
#' Iterate over sequence length of input and return list(s)
#'
#' @param .data The sequence length, used as ".i" in the following expression
#' @param .f Function or formula call that assumes integer element is .i
#' @param ... Other values passed to function call.
#' @return A list
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
  if (is_lang(.f)) {
    e <- call_env()
    lapply(seq_along(.data), function(.i) {
      eval(eval(.f, envir = e)[[2]], list(.i = .i), e)
    })
  } else {
    lapply(.data, .f, ...)
  }
}
