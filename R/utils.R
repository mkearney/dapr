is_lang <- function(x) identical(typeof(x), "language")

use_method <- function(method, ...) {
  args <- c(as.list(parent.frame(), all.names = TRUE), dots(...))
  args <- args[grep("\\.\\.\\.", names(args), invert = TRUE)]
  do_call(method, args)
}

do_call <- function(method, args) {
  do.call(default_method(method), args, quote = TRUE)
}

default_method <- function(x) paste0(x, ".default")

dots <- function(...) {
  eval(substitute(alist(...)), envir = parent.frame())
}
