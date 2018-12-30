is_lang <- function(x) identical(typeof(x), "language")

call_env <- function(n = 1) parent.frame(n + 1)
