
#' List apply
#'
#' Iterate over input and return list(s)
#'
#' @param .data Input vector
#' @param .f Function or formula call that assumes element is .x
#' @param ... Other args passed to function call
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
lap <- function(.data, .f, ...) use_method("lap", ...)

lap.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    lapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    })
  } else {
    lapply(.data, .f, ...)
  }
}
