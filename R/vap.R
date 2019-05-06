#' vap: Vector apply functions
#'
#' Functions that apply expressions to input data objects and return atomic
#' vectors e.g., numeric (double), character, logical.
#'
#' @name vap
#' @seealso \code{\link{dap}} \code{\link{lap}}
NULL

#' Vector apply double
#'
#' vap_dbl: Iterate over input and return double(s)
#'
#' @param .data Input object–numeric, character, list, data frame, etc.–over
#'   which elements will be iterated. If matrix or data frame, each
#'   column will be treated as the elements which are to be iterated over.
#' @param .f Function to apply to each element of input object. This can be
#'   written as a single function name e.g., \code{mean}, a formula-like
#'   function call where '.x' is assumed to be the iterated over element of
#'   input data e.g., \code{~ mean(.x)}, or an in-line function definition e.g.,
#'   \code{function(x) mean(x)}.
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
    .f <- eval(.f, envir = e)[[2]]
    vapply(.data,
      function(.x) eval(.f, list(.x = .x), e),
      FUN.VALUE = numeric(1))
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = numeric(1))
  }
}


#' Vector apply character
#'
#' vap_chr: Iterate over input and return character(s)
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
    .f <- eval(.f, envir = e)[[2]]
    vapply(.data,
      function(.x) eval(.f, list(.x = .x), e),
      FUN.VALUE = character(1))
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = character(1))
  }
}


#' Vector apply logical
#'
#' vap_lgl: Iterate over input and return logical(s)
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
    .f <- eval(.f, envir = e)[[2]]
    vapply(.data,
      function(.x) eval(.f, list(.x = .x), e),
      FUN.VALUE = logical(1))
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = logical(1))
  }
}



#' Vector apply integer
#'
#' vap_int: Iterate over input and return integer(s)
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
    .f <- eval(.f, envir = e)[[2]]
    vapply(.data,
      function(.x) eval(.f, list(.x = .x), e),
      FUN.VALUE = integer(1))
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = integer(1))
  }
}
