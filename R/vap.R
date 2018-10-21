#' Vector apply character
#'
#' Iterate over input and return character(s)
#'
#' @inheritParams vap_dbl
#' @return A character vector
#' @param ... Args
#' @export
#' @rdname vap
vap_chr <- function(.data, .f, ...) use_method("vap_chr", ...)

vap_chr.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    vapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    }, FUN.VALUE = character(1))
  } else {
    vapply(.data, .f, ..., FUN.VALUE = character(1))
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
vap_dbl <- function(.data, .f, ...) use_method("vap_dbl", ...)

vap_dbl.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    vapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    }, FUN.VALUE = numeric(1))
  } else {
    vapply(.data, .f, ..., FUN.VALUE = numeric(1))
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
vap_lgl <- function(.data, .f, ...) use_method("vap_lgl", ...)

vap_lgl.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    vapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    }, FUN.VALUE = logical(1))
  } else {
    vapply(.data, .f, ..., FUN.VALUE = logical(1))
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
vap_int <- function(.data, .f, ...) use_method("vap_int", ...)

vap_int.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    vapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    }, FUN.VALUE = integer(1))
  } else {
    vapply(.data, .f, ..., FUN.VALUE = integer(1))
  }
}
