#' vapr: Vector apply-to-column functions
#'
#' Functions that apply expressions to the columns of input objects and return
#' atomic vectors e.g., numeric (double), integer, character, logical.
#'
#' @name vapc
#' @family vap
#' @seealso \code{\link{lap}}  \code{\link{dap}}
NULL

#' Vector apply-to-column character
#'
#' vapc_chr: Iterate over input \strong{columns} and return \strong{character(s)}
#'
#' @param .data Input object–must be two-dimensional (e.g., matrix, data.frame)
#'   –over which the second dimension (columns) will be iterated
#' @inheritParams vap_dbl
#' @return A character vector
#' @export
#' @rdname vapc
vapc_chr <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(ncol(.data)), function(.i) {
      eval(.f, list(.x = .data[, .i, drop = FALSE]), e)
    }, FUN.VALUE = character(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(ncol(.data)), function(.i) {
      as.character(.data[.f, .i, drop = TRUE])
    }, FUN.VALUE = character(1))
  } else {
    vapply(seq_len(ncol(.data)), function(.i) {
      .f(.data[, .i, drop = FALSE], ...)
    }, FUN.VALUE = character(1))
  }
}


#' Vector apply-to-column numeric
#'
#' vapc_dbl: Iterate over input \strong{columns} and return \strong{numeric(s)}
#'
#' @inheritParams vapc_chr
#' @return A numeric vector
#' @export
#' @rdname vapc
vapc_dbl <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(ncol(.data)), function(.i) {
      eval(.f, list(.x = .data[, .i, drop = FALSE]), e)
    }, FUN.VALUE = numeric(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(ncol(.data)), function(.i) {
      as.numeric(.data[.f, .i, drop = TRUE])
    }, FUN.VALUE = numeric(1))
  } else {
    vapply(seq_len(ncol(.data)), function(.i) {
      .f(.data[, .i, drop = FALSE], ...)
    }, FUN.VALUE = numeric(1))
  }
}

#' Vector apply-to-column logical
#'
#' vapc_lgl: Iterate over input \strong{columns} and return \strong{logical(s)}
#'
#' @inheritParams vapc_chr
#' @return A logical vector
#' @export
#' @rdname vapc
vapc_lgl <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(ncol(.data)), function(.i) {
      eval(.f, list(.x = .data[, .i, drop = FALSE]), e)
    }, FUN.VALUE = logical(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(ncol(.data)), function(.i) {
      as.logical(.data[.f, .i, drop = TRUE])
    }, FUN.VALUE = logical(1))
  } else {
    vapply(seq_len(ncol(.data)), function(.i) {
      .f(.data[, .i, drop = FALSE], ...)
    }, FUN.VALUE = logical(1))
  }
}

#' Vector apply-to-column integer
#'
#' vapc_int: Iterate over input \strong{columns} and return \strong{integer(s)}
#'
#' @inheritParams vapc_chr
#' @return An integer vector
#' @export
#' @rdname vapc
vapc_int <- function(.data, .f, ...) {
  assert_that(is_2d(.data))
  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    vapply(seq_len(ncol(.data)), function(.i) {
      eval(.f, list(.x = .data[, .i, drop = FALSE]), e)
    }, FUN.VALUE = integer(1))
  } else if (is.atomic(.f)) {
    vapply(seq_len(ncol(.data)), function(.i) {
      as.integer(.data[.f, .i, drop = TRUE])
    }, FUN.VALUE = integer(1))
  } else {
    vapply(seq_len(ncol(.data)), function(.i) {
      .f(.data[, .i, drop = FALSE], ...)
    }, FUN.VALUE = integer(1))
  }
}
