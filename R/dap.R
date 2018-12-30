#' Data frame apply function
#'
#' Applies functions to columns (default) of data frame
#'
#' @param .data Data frame input.
#' @param .f Function to apply to element (columns or rows).
#' @param ... Other values passed to function call.
#' @return A data frame
#' @export
#' @rdname dap
dapc <- function(.data, .f, ...) UseMethod("dapc")

#' @export
dapc.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    .data[] <- lapply(.data, function(.x) {
      eval(eval(.f, envir = e)[[2]], list(.x = .x), e)
    })
  } else {
    .data[] <- lapply(.data, .f, ...)
  }
  .data
}

#' @rdname dap
#' @export
dapr <- function(.data, .f, ...) UseMethod("dapr")

#' @export
dapr.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    e <- call_env()
    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1,
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e)
    ))
  } else {
    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1, .f, ...))
  }
  .data
}



#' @rdname dap
#' @inheritParams dap
#' @param .predicate Logical vector of expression evaluating to a logical vector
#' @export
dapc_if <- function(.data, .predicate, .f, ...) UseMethod("dapc_if")

#' @export
dapc_if.default <- function(.data, .predicate, .f, ...) {
  if (is.logical(.predicate)) {
    lg <- .predicate
  } else if (is_lang(.predicate)) {
    e <- call_env()
    lg <- vapply(.data,
      function(.x) eval(eval(.predicate, envir = e)[[2]], list(.x = .x), e),
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  } else {
    lg <- vapply(.data, .predicate,
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  }
  stopifnot(is.logical(lg))

  if (is_lang(.f)) {
    e <- call_env()
    .data[lg] <- lapply(.data[lg],
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e)
    )
  } else {
    .data[lg] <- lapply(.data[lg], .f, ...)
  }
  .data
}



#' @rdname dap
#' @inheritParams dap
#' @export
dapr_if <- function(.data, .predicate, .f, ...) UseMethod("dapr_if")

#' @export
dapr_if.default <- function(.data, .predicate, .f, ...) {
  if (is.logical(.predicate)) {
    lg <- .predicate
  } else if (is_lang(.predicate)) {
    e <- call_env()
    lg <- unlist(apply(.data, 1,
      function(.x) eval(eval(.predicate, envir = e)[[2]], list(.x = .x), e)
    ))
  } else {
    lg <- vapply(.data, .predicate,
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  }
  stopifnot(is.logical(lg))
  if (sum(lg) == 0) return(.data)

  if (is_lang(.f)) {
    e <- call_env()
    .data[lg, ] <- t(apply(.data[lg, ], 1,
      function(.x) eval(eval(.f, envir = e)[[2]], list(.x = .x), e)
    ))
  } else {
    .data[lg, ] <- t(apply(.data[lg, ], 1, .f, ...))
  }
  .data
}
