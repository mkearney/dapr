#' Vector apply character
#'
#' Iterate over input and return character(s)
#'
#' @inheritParams vap_dbl
#' @return A character vector
#' @export
#' @rdname vap
vap_chr <- function(.x, .f, ...) UseMethod("vap_chr")

#' @export
vap_chr.default <- function(.x, .f, ...) {
  e <- new.env()
  o <- character(length(.x))
  for (i in seq_along(.x)) {
    assign(".x", .x[[i]], envir = e)
    if (is_lang(.f)) {
      o[i] <- as_chr(eval(.f[[2]], envir = e))
    } else {
      o[i] <- as_chr(do.call(.f, list(.x[[i]], ...)))
    }
  }
  o
}


#' Vector apply double
#'
#' Iterate over input and return double(s)
#'
#' @param .x Input vector
#' @param .f Function or formula call that assumes element is .x
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
#' @rdname vap
vap_dbl <- function(.x, .f, ...) UseMethod("vap_dbl")

#' @export
vap_dbl.default <- function(.x, .f, ...) {
  e <- new.env()
  o <- double(length(.x))
  for (i in seq_along(.x)) {
    assign(".x", .x[[i]], envir = e)
    if (is_lang(.f)) {
      o[i] <- as_dbl(eval(.f[[2]], envir = e))
    } else {
      o[i] <- as_dbl(do.call(.f, list(.x[[i]], ...)))
    }
  }
  o
}




#' Vector apply logical
#'
#' Iterate over input and return logical(s)
#'
#' @inheritParams vap_dbl
#' @return A logical vector
#' @export
#' @rdname vap
vap_lgl <- function(.x, .f, ...) UseMethod("vap_lgl")

#' @export
vap_lgl.default <- function(.x, .f, ...) {
  e <- new.env()
  o <- logical(length(.x))
  for (i in seq_along(.x)) {
    assign(".x", .x[[i]], envir = e)
    if (is_lang(.f)) {
      o[i] <- as_lgl(eval(.f[[2]], envir = e))
    } else {
      o[i] <- as_lgl(do.call(.f, list(.x[[i]], ...)))
    }
  }
  o
}
