
#' List apply
#'
#' Iterate over input and return list(s)
#'
#' @param .x Input vector
#' @param .f Function or formula call that assumes element is .x
#' @return A list
#' @export
#' @examples
#'
#' ## return string list
#' lap(letters, ~ paste0(.x, "."))
#'
#' ## return list of columns
#' lap(mtcars[1:5, ], as.character)
#'
#' @rdname vap
lap <- function(.x, .f, ...) UseMethod("lap")

#' @export
lap.default <- function(.x, .f, ...) {
  e <- new.env()
  o <- vector("list", length(.x))
  for (i in seq_along(.x)) {
    assign(".x", .x[[i]], envir = e)
    if (is_lang(.f)) {
      o[[i]] <- as_lst(eval(.f[[2]], envir = e))
    } else {
      o[[i]] <- as_lst(do.call(.f, list(.x[[i]], ...)))
    }
  }
  o
}
