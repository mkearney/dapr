#' vap: Vector apply functions
#'
#' Functions that apply expressions to input objects and return atomic vectors
#' e.g., numeric (double), integer, character, logical.
#'
#' @name vap
#' @family vap
#' @seealso \code{\link{lap}}  \code{\link{dap}}
NULL

#' Vector apply double
#'
#' vap_dbl: Iterate over input and return double(s)
#'
#' @param .data Input object–numeric, character, list, data frame, etc.–over
#'   which elements will be iterated. If matrix or data frame, each
#'   column will be treated as an element.
#' @param .f Action to apply to each element of \code{.data}. The action can be
#'   articulated in one of the four following ways:
#' \enumerate{
#' \item supplying a function object (e.g., \code{mean})
#' \item defining a function (in-line; e.g., \code{function(x) mean(x)})
#' \item specifying a formula-like call where '.x' is assumed to be the iterated
#'   over element of \code{.data} (e.g., \code{~ mean(.x)})
#' \item providing a name or position of \code{.data} to return (e.g.,
#'   \code{1}, \code{"varname"}, etc.)
#' }
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
#' vap_int(as.data.frame(replicate(10, sample(1:10))), 8)
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
  } else if (is.atomic(.f)) {
    as.numeric(getElement(.data, .f))
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
  } else if (is.atomic(.f)) {
    as.character(getElement(.data, .f))
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
  } else if (is.atomic(.f)) {
    as.logical(getElement(.data, .f))
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
#' @return An integer vector
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
  } else if (is.atomic(.f)) {
    as.integer(getElement(.data, .f))
  } else {
    vapply(.data, .f, ...,
      FUN.VALUE = integer(1))
  }
}







