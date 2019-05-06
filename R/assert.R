
assert_that <- function(..., env = parent.frame(), msg = NULL) {
  res <- see_if(..., env = env, msg = msg)
  if (res) return(TRUE)

  stop(assert_error(attr(res, "msg")))
}

assert_error <- function (message, call = NULL) {
  class <- c("assert_error", "simpleError", "error", "condition")
  structure(list(message = message, call = call), class = class)
}

see_if <- function(..., env = parent.frame(), msg = NULL) {
  asserts <- eval(substitute(alist(...)))

  for (assertion in asserts) {
    res <- tryCatch({
      eval(assertion, env)
    }, assert_error = function(e) {
      structure(FALSE, msg = e$message)
    })

    if (!res) {
      if (is.null(msg))
        msg <- get_message(res, assertion, env)
      return(structure(FALSE, msg = msg))
    }
  }

  res
}


has_msg <- function(x) !is.null(attr(x, "msg", exact = TRUE))

get_message <- function(res, call, env = parent.frame()) {
  if (has_msg(res)) {
    return(attr(res, "msg"))
  }
  f <- eval(call[[1]], env)
  if (!is.primitive(f)) call <- match.call(f, call)
  fname <- deparse(call[[1]])
  fail <- on_fail(f) %||% base_fs[[fname]] %||% fail_default
  fail(call, env)
}

fail_default <- function(call, env) {
  call_string <- deparse(call, width.cutoff = 60L)
  if (length(call_string) > 1L) {
    call_string <- paste0(call_string[1L], "...")
  }
  paste0(call_string, " is not TRUE")
}

on_fail <- function(x) attr(x, "fail")

base_fs <- new.env(parent = emptyenv())


