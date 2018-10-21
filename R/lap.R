
#' List apply
#'
#' Iterate over input and return list(s)
#'
#' @param .x Input vector
#' @param .f Function or formula call that assumes element is .x
#' @return A list
#' @examples
#'
#' ## return string list
#' lap(letters, ~ paste0(.x, "."))
#'
#' ## return list of columns
#' lap(mtcars[1:5, ], as.character)
#'
#' @export
lap <- function(.data, .f, ...) use_method("lap", ...)

#' @export
lap.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    lapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    })
  } else {
    lapply(.data, .f, ...)
  }
}


#' @export
lap.tbl_df <- function(.data, .f, ...) {
  .data <- as.data.frame(.data)
  lap(.data, .f, ...)
}

#' @rdname lap
#' @export
dapc <- function(.data, .f, ...) use_method("dapc", ...)

#' @export
dapc.default <- function(.data, .f, ...) {
  if (is_lang(.f)) {
    .data[] <- lapply(.data, function(.x) {
      eval(.f[[2]], envir = new.env())
    })
  } else {
    .data[] <- local(lapply(.data, .f, ...), envir = new.env())
  }
  .data
}

#' @rdname lap
#' @export
dapr <- function(.data, .f, ...) use_method("dapr", ...)

#' @export
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


#' @rdname lap
#' @export
dapc_if <- function(.data, .predicate, .f, ...) use_method("dapc_if", ...)

#' @export
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
