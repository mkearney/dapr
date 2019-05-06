#' dap: Data frame apply functions
#'
#' Functions that apply expressions to input data objects and return data
#' frames.
#'
#' @name dap
#' @seealso \code{\link{lap}} \code{\link{vap}}
NULL

#' Data frame apply functions
#'
#' dapc: Apply function to columns of a data frame.
#'
#' @param .data Data frame input.
#' @param .f Function to apply to element (columns or rows). This can be written
#'   as a single function name e.g., \code{mean}, a formula-like function call
#'   where '.x' is assumed to be the iterated over element of input data e.g.,
#'   \code{~ mean(.x)}, or an in-line function definition e.g.,
#'   \code{function(x) mean(x)}.
#' @param ... Other values passed to function call.
#' @return A data frame
#' @family dap
#' @export
#' @rdname dap
dapc <- function(.data, .f, ...) UseMethod("dapc")

#' @export
dapc.default <- function(.data, .f, ...) {
  assert_that(is_vector(.data))

  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    .data[] <- lapply(.data, function(.x) {
      eval(.f, list(.x = .x), e)
    })
  } else {
    .data[] <- lapply(.data, .f, ...)
  }
  .data
}

#' @rdname dap
#' @description dapr: Apply function to rows of a data frame.
#' @family dap
#' @export
dapr <- function(.data, .f, ...) UseMethod("dapr")

#' @export
dapr.default <- function(.data, .f, ...) {
  assert_that(is_vector(.data))

  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1,
      function(.x) eval(.f, list(.x = .x), e)
    ))
  } else {
    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1, .f, ...))
  }
  .data
}



#' @rdname dap
#' @description dapc_if: Apply function to certain columns of a data frame.
#' @inheritParams dap
#' @param .predicate Logical vector or expression evaluating to a logical vector.
#'   If not a logical vector, this can be written as a single function name
#'   e.g., \code{is.numeric}, a formula-like function call where '.x' is assumed
#'   to be the iterated over element of input data e.g.,
#'   \code{~ is.numeric(.x)}, or an in-line function definition e.g.,
#'   \code{function(x) is.numeric(x)}. Regardless, if a logical vector is not
#'   provided, this expression must return a logical vector of the same length
#'   as the input .data object.
#'
#'   The resulting logical vector is used to determine which elements (rows or
#'   columns) to iterate over with the .f function/expression.
#' @family dap
#' @export
dapc_if <- function(.data, .predicate, .f, ...) UseMethod("dapc_if")

#' @export
dapc_if.default <- function(.data, .predicate, .f, ...) {
  assert_that(is_vector(.data))

  if (is.logical(.predicate)) {
    lg <- .predicate
  } else if (is_lang(.predicate)) {
    e <- call_env()
    .predicate <- eval(.predicate, envir = e)[[2]]
    lg <- vapply(.data,
      function(.x) eval(.predicate, list(.x = .x), e),
      FUN.VALUE = logical(1))
  } else {
    lg <- vapply(.data, .predicate,
      FUN.VALUE = logical(1))
  }
  assert_that(is.logical(lg))

  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    .data[lg] <- lapply(.data[lg],
      function(.x) eval(.f, list(.x = .x), e)
    )
  } else {
    .data[lg] <- lapply(.data[lg], .f, ...)
  }
  .data
}



#' @rdname dap
#' @description dapr_if: Apply function to certain rows of a data frame.
#' @inheritParams dap
#' @family dap
#' @export
dapr_if <- function(.data, .predicate, .f, ...) UseMethod("dapr_if")

#' @export
dapr_if.default <- function(.data, .predicate, .f, ...) {
  assert_that(is_vector(.data))

  if (is.logical(.predicate)) {
    lg <- .predicate
  } else if (is_lang(.predicate)) {
    e <- call_env()
    .predicate <- eval(.predicate, envir = e)[[2]]
    lg <- unlist(apply(.data, 1,
      function(.x) eval(.predicate, list(.x = .x), e)
    ))
  } else {
    lg <- vapply(.data, .predicate,
      FUN.VALUE = logical(1))
  }
  assert_that(is.logical(lg))
  if (sum(lg) == 0) return(.data)

  if (is_lang(.f)) {
    e <- call_env()
    .f <- eval(.f, envir = e)[[2]]
    .data[lg, ] <- t(apply(.data[lg, ], 1,
      function(.x) eval(.f, list(.x = .x), e)
    ))
  } else {
    .data[lg, ] <- t(apply(.data[lg, ], 1, .f, ...))
  }
  .data
}
