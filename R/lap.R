
#' List apply
#'
#' Iterate over input and return list(s)
#'
#' @param .data Input vector
#' @param .f Function or formula call that assumes element is .x
#' @param ... Other values passed to function call.
#' @return A list
#' @examples
#'
#' ## return string list
#' lap(letters, ~ paste0(.x, "."))
#'
#' ## return list of columns
#' lap(mtcars[1:5, ], as.character)
#'
#' @export
lap <- function(.data, .f, ...) UseMethod("lap")

#' @export
lap.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    lapply(.data, function(.x) {
      eval(eval(.f, envir = e)[[2]], list(.x = .x), e)
    })
  } else {
    lapply(.data, .f, ...)
  }
}

