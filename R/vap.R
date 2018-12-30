#' Vector apply character
#'
#' Iterate over input and return character(s)
#'
#' @inheritParams vap_dbl
#' @return A character vector
#' @param ... Other values passed to function call.
#' @export
#' @rdname vap
vap_chr <- function(.data, .f, ...) UseMethod("vap_chr")

#' @export
vap_chr.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    vapply(.data,
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e),
      FUN.VALUE = character(1),
      USE.NAMES = FALSE)
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = character(1),
      USE.NAMES = FALSE)
  }
}


#' Vector apply double
#'
#' Iterate over input and return double(s)
#'
#' @param .data Input vector
#' @param .f Function or formula call that assumes element is .data
#' @return A double vector
#' @export
#' @examples
#'
#' ## character
#' vap_chr(letters, ~ paste0(.x, "."))
#'
#' ## double
#' vap_dbl(rnorm(4), round, 3)
#'
#' ## logical
#' vap_lgl(letters, ~ .x %in% c("a", "e", "i", "o", "u"))
#'
#' ## integer
#' vap_int(rnorm(5), ~ as.integer(.x))
#'
#' @rdname vap
vap_dbl <- function(.data, .f, ...) UseMethod("vap_dbl")

#' @export
vap_dbl.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    vapply(.data,
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e),
      FUN.VALUE = numeric(1),
      USE.NAMES = FALSE)
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = numeric(1),
      USE.NAMES = FALSE)
  }
}




#' Vector apply logical
#'
#' Iterate over input and return logical(s)
#'
#' @inheritParams vap_dbl
#' @return A logical vector
#' @export
#' @rdname vap
vap_lgl <- function(.data, .f, ...) UseMethod("vap_lgl")

#' @export
vap_lgl.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    vapply(.data,
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e),
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  }
}



#' Vector apply integer
#'
#' Iterate over input and return integer(s)
#'
#' @inheritParams vap_dbl
#' @return A integer vector
#' @export
#' @rdname vap
vap_int <- function(.data, .f, ...) UseMethod("vap_int")

#' @export
vap_int.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    vapply(.data,
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e),
      FUN.VALUE = integer(1),
      USE.NAMES = FALSE)
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = integer(1),
      USE.NAMES = FALSE)
  }
}
