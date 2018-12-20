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
dapc <- function(.data, .f, ...) use_method("dapc", ...)

dapc.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    ## call environment
    e <- call_env(.f)

    ## map over elements of data
    .data[] <- lapply(.data, function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.f[[2]], envir = e)
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
    ## call environment
    e <- call_env(.f)

    .data[seq_len(nrow(.data)), ] <- t(apply(.data, 1, function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.f[[2]], envir = e)

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

    ## call environment
    e <- call_env(.predicate)

    lg <- vapply(.data, function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.predicate[[2]], envir = e)

    }, FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  } else {
    lg <- vapply(.data, .predicate,
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  }
  stopifnot(is.logical(lg))

  if (is_lang(.f)) {
    ## call environment
    e <- call_env(.f)

    .data[lg] <- lapply(.data[lg], function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.f[[2]], envir = e)

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

    ## call environment
    e <- call_env(.predicate)

    lg <- unlist(apply(.data, 1, function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.predicate[[2]], envir = e)

    }))
  } else {
    lg <- vapply(.data, .predicate,
      FUN.VALUE = logical(1),
      USE.NAMES = FALSE)
  }
  stopifnot(is.logical(lg))
  if (sum(lg) == 0) return(.data)

  if (is_lang(.f)) {
    ## call environment
    e <- call_env(.f)

    .data[lg, ] <- t(apply(.data[lg, ], 1, function(.x) {

      ## assign .x (and override each time)
      assign(".x", .x, envir = e)

      ## evaluate in modified call environment
      eval(.f[[2]], envir = e)

    }))
  } else {
    .data[lg, ] <- t(apply(.data[lg, ], 1, .f, ...))
  }
  .data
}
