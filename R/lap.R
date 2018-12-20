
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
    ## call environment
    e <- call_env(.f)

    ## map via lapply
    lapply(.data, function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.f[[2]], envir = e)
    })
  } else {
    lapply(.data, .f, ...)
  }
}

