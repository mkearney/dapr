#' vapr: Vector apply-to-row functions
#'
#' Functions that apply expressions to the rows of input objects and return
#' atomic vectors e.g., numeric (double), integer, character, logical.
#'
#' @name vapr
#' @family vap
#' @seealso \code{\link{lap}}  \code{\link{dap}}
NULL

#' Vector apply-to-row character
#'
#' vapr_chr: Iterate over input \strong{rows} and return \strong{character(s)}
#'
#' @param .data Input object–must be two-dimensional (e.g., matrix, data.frame)
#'   –over which the first dimension (rows) will be iterated
#' @inheritParams vap_dbl
#' @return A character vector
#' @export
#' @rdname vapr
vapr_chr <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(nrow(.data)), function(.i) {
      eval(.f, list(.x = .data[.i, , drop = FALSE]), e)
    }, FUN.VALUE = character(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(nrow(.data)), function(.i) {
      as.character(.data[.i, .f, drop = TRUE])
    }, FUN.VALUE = character(1))
  } else {
    vapply(seq_len(nrow(.data)), function(.i) {
      .f(.data[.i, , drop = FALSE], ...)
    }, FUN.VALUE = character(1))
  }
}


#' Vector apply-to-row numeric
#'
#' vapr_dbl: Iterate over input \strong{rows} and return \strong{numeric(s)}
#'
#' @inheritParams vapr_chr
#' @return A numeric vector
#' @export
#' @rdname vapr
vapr_dbl <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(nrow(.data)), function(.i) {
      eval(.f, list(.x = .data[.i, , drop = FALSE]), e)
    }, FUN.VALUE = numeric(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(nrow(.data)), function(.i) {
      as.numeric(.data[.i, .f, drop = TRUE])
    }, FUN.VALUE = numeric(1))
  } else {
    vapply(seq_len(nrow(.data)), function(.i) {
      .f(.data[.i, , drop = FALSE], ...)
    }, FUN.VALUE = numeric(1))
  }
}

#' Vector apply-to-row logical
#'
#' vapr_lgl: Iterate over input \strong{rows} and return \strong{logical(s)}
#'
#' @inheritParams vapr_chr
#' @return A logical vector
#' @export
#' @rdname vapr
vapr_lgl <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(nrow(.data)), function(.i) {
      eval(.f, list(.x = .data[.i, , drop = FALSE]), e)
    }, FUN.VALUE = logical(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(nrow(.data)), function(.i) {
      as.logical(.data[.i, .f, drop = TRUE])
    }, FUN.VALUE = logical(1))
  } else {
    vapply(seq_len(nrow(.data)), function(.i) {
      .f(.data[.i, , drop = FALSE], ...)
    }, FUN.VALUE = logical(1))
  }
}

#' Vector apply-to-row integer
#'
#' vapr_int: Iterate over input \strong{rows} and return \strong{integer(s)}
#'
#' @inheritParams vapr_chr
#' @return An integer vector
#' @export
#' @rdname vapr
vapr_int <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(nrow(.data)), function(.i) {
      eval(.f, list(.x = .data[.i, , drop = FALSE]), e)
    }, FUN.VALUE = integer(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(nrow(.data)), function(.i) {
      as.integer(.data[.i, .f, drop = TRUE])
    }, FUN.VALUE = integer(1))
  } else {
    vapply(seq_len(nrow(.data)), function(.i) {
      .f(.data[.i, , drop = FALSE], ...)
    }, FUN.VALUE = integer(1))
  }
}
