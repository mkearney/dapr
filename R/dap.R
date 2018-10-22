#' Data frame apply function
#'
#' Applies functions to columns (default) of data frame
#'
#' @param .data Data frame input.
#' @param .f Function to apply to element (columns or rows)
#' @param ... Other args passed to function call
#' @return A data frame
#' @export
#' @rdname dap
dapc <- function(.data, .f, ...) use_method("dapc", ...)

dapc.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    .data[] <- lapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    })
  } else {
    .data[] <- lapply(.data, .f, ...)
  }
  .data
}

#' @rdname dap
#' @export
dapr <- function(.data, .f, ...) use_method("dapr", ...)

dapr.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1, function(.x) {
      eval(.f[[2]], envir = new.env())
    }))
  } else {
    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1, .f, ...))
  }
  .data
}



#' @rdname dap
#' @inheritParams dap
#' @param .predicate Logical vector of expression evaluating to a logical vector
#' @export
dapc_if <- function(.data, .predicate, .f, ...) use_method("dapc_if", ...)

dapc_if.default <- function(.data, .predicate, .f, ...) {
  if (is.logical(.predicate)) {
    lg <- .predicate
  } else if (is_lang(.predicate)) {
    lg <- vapply(.data, function(.x) {
      eval(.predicate[[2]], envir = new.env())
    }, logical(1))
  } else {
    lg <- vapply(.data, .predicate, logical(1))
  }
  stopifnot(is.logical(lg))
  if (is_lang(.f)) {
    .data[lg] <- lapply(.data[lg], function(.x) {
      eval(.f[[2]], envir = new.env())
    })
  } else {
    .data[lg] <- lapply(.data[lg], .f, ...)
  }
  .data
}



#' @rdname dap
#' @inheritParams dap
#' @export
dapr_if <- function(.data, .predicate, .f, ...) use_method("dapr_if", ...)

dapr_if.default <- function(.data, .predicate, .f, ...) {
  if (is.logical(.predicate)) {
    lg <- .predicate
  } else if (is_lang(.predicate)) {
    lg <- unlist(apply(.data, 1, function(.x) {
      eval(.predicate[[2]], envir = new.env())
    }))
  } else {
    lg <- vapply(.data, .predicate, logical(1))
  }
  stopifnot(is.logical(lg))
  if (sum(lg) == 0) return(.data)
  if (is_lang(.f)) {
    .data[lg, ] <- t(apply(.data[lg, ], 1, function(.x) {
      eval(.f[[2]], envir = new.env())
    }))
  } else {
    .data[lg, ] <- t(apply(.data[lg, ], 1, .f, ...))
  }
  .data
}
