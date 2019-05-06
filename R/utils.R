is_lang <- function(x) identical(typeof(x), "language")

call_env <- function(n = 1) parent.frame(n + 1)

is_vector <- function(x) {
  if (is.atomic(x) || is.list(x) || is.call(x)) {
    return(TRUE)
  }
  FALSE
}

"%||%" <- function(a, b) if (is.null(a)) b else a

