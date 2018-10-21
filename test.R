d <- tbltools::as_tbl(mtcars, row.names = TRUE)
d <- tibble::as_tibble(d)

lap(d[-1], ~ round(.x, 3))
lap(d[-1], round, 3)

dapc(d[-1], ~ round(.x, 3))
dapc(d[-1], round, 3)

dapr(d[-1], ~ round(.x, 3))
dapr(d[-1], round, 3)

dapc_if(d, is.numeric, ~ round(.x, 3))
dapc_if(d, is.numeric, round, 3)




