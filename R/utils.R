as_lgl <- function(expr) {
  o <- tryCatch(expr, error = function(e) NULL)
  if (length(o) == 0) {
    o <- NA
  }
  if (!is.logical(o)) {
    o <- tryCatch(as.logical(o), error = function(e) NULL)
  }
  if (length(o) != 1L) stop("must return 1 lgl")
  o
}



is_closure <- function(x) identical(typeof(x), "closure")
is_lang <- function(x) identical(typeof(x), "language")




as_dbl <- function(expr) {
  o <- tryCatch(expr, error = function(e) NULL)
  if (length(o) == 0) {
    o <- NA_real_
  }
  if (!is.double(o)) {
    o <- tryCatch(as.double(o), error = function(e) NULL)
  }
  if (length(o) != 1L) stop("must return 1 dbl")
  o
}


as_chr <- function(expr) {
  o <- tryCatch(expr, error = function(e) NULL)
  if (length(o) == 0) {
    o <- NA_character_
  }
  if (!is.character(o)) {
    o <- tryCatch(as.character(o), error = function(e) NULL)
  }
  if (length(o) != 1L) stop("must return 1 chr")
  o
}



as_lst <- function(expr) {
  o <- tryCatch(expr, error = function(e) NULL)
  if (length(o) == 0) {
    o <- list()
  }
  if (!is.list(o)) {
    o <- list(o)
  }
  if (length(o) != 1L) stop("must return 1 chr")
  o
}
