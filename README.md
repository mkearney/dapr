
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dapr

[![Build
status](https://travis-ci.org/mkearney/dapr.svg?branch=master)](https://travis-ci.org/mkearney/dapr)
[![CRAN
status](https://www.r-pkg.org/badges/version/dapr)](https://cran.r-project.org/package=dapr)
[![Coverage
Status](https://codecov.io/gh/mkearney/dapr/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/dapr?branch=master)

<!--#![Downloads](https://cranlogs.r-pkg.org/badges/dapr)
#![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/dapr)-->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

Iterating for loops. A dependency-free purrr-like iterator.

## Installation

Install the development version from Github with:

``` r
## install remotes pkg if not already
if (!requireNamespace("remotes")) {
  install.packages("remotes")
}

## install from github
remotes::install_github("mkearney/dapr")
```

## {dapr} vs. {base} & {purrr}?

**{dapr}** provides the ease and consistency of
[**{purrr}**](https://purrr.tidyverse.org), including use of `~` and
`.x`, without all the dependencies. In other words, when you want a
purrr-like experience but you need a lightweight solution.

## Vectors

  - **`vap_dbl()`** Iterate and return **numeric** vector.
  - **`vap_int()`** Iterate and return **integer** vector.
  - **`vap_lgl()`** Iterate and return **logical** vector.
  - **`vap_chr()`** Iterate and return **character** vector.

<!-- end list -->

``` r
## create data
set.seed(12)
d <- replicate(5, rnorm(10), simplify = FALSE)
e <- replicate(5, sample(letters, 10), simplify = FALSE)

## numeric
vap_dbl(d, ~ mean(.x))
#> [1] -0.4672139 -0.1952043  0.2087615 -0.0134176 -0.2475739

## integer
vap_int(d, length)
#> [1] 10 10 10 10 10

## logical
vap_lgl(d, ~ max(.x) > 3)
#> [1] FALSE FALSE FALSE FALSE FALSE

## character
vap_chr(e, paste, collapse = "")
#> [1] "mvktopwdci" "thqbcmiulp" "rwuvznlmoj" "ufxdasqmpk" "hvoqzmiwty"
```

## Lists

  - **`lap()`** Iterate and return a **list** vector.

<!-- end list -->

``` r
## list of strings
lap(e[1:3], ~ paste0(.x, "."))
#> [[1]]
#>  [1] "m." "v." "k." "t." "o." "p." "w." "d." "c." "i."
#> 
#> [[2]]
#>  [1] "t." "h." "q." "b." "c." "m." "i." "u." "l." "p."
#> 
#> [[3]]
#>  [1] "r." "w." "u." "v." "z." "n." "l." "m." "o." "j."

## list of columns
lap(e[1:3], toupper)
#> [[1]]
#>  [1] "M" "V" "K" "T" "O" "P" "W" "D" "C" "I"
#> 
#> [[2]]
#>  [1] "T" "H" "Q" "B" "C" "M" "I" "U" "L" "P"
#> 
#> [[3]]
#>  [1] "R" "W" "U" "V" "Z" "N" "L" "M" "O" "J"
```

## Data frames

  - **`dap()`** Iterate (over columns) and return a **data frame**.
  - **`dapc()`** Iterate over **columns**.
  - **`dapr()`** Iterate over **rows**.
  - **`dapc_if()`** Iterate over **columns** meeting logical test.

<!-- end list -->

``` r
## some data
d <- data.frame(
  a = letters[1:5],
  b = rnorm(5),
  c = rnorm(5),
  stringsAsFactors = FALSE
)

## default applies to columns
dap(d[-1], ~ round(.x, 2))
#>       b     c
#> 1 -0.63  0.00
#> 2 -1.27 -1.27
#> 3 -0.38 -0.20
#> 4  0.52  1.16
#> 5 -0.18 -0.02

## column explicit
dapc(d[-1], ~ round(.x, 2))
#>       b     c
#> 1 -0.63  0.00
#> 2 -1.27 -1.27
#> 3 -0.38 -0.20
#> 4  0.52  1.16
#> 5 -0.18 -0.02

## rows
dapr(d[-1], round, 3)
#>        b      c
#> 1 -0.634  0.004
#> 2 -1.271 -1.274
#> 3 -0.384 -0.202
#> 4  0.517  1.164
#> 5 -0.178 -0.023

## predicate columns
dapc_if(d, is.numeric, ~ round(.x, 1))
#>   a    b    c
#> 1 a -0.6  0.0
#> 2 b -1.3 -1.3
#> 3 c -0.4 -0.2
#> 4 d  0.5  1.2
#> 5 e -0.2  0.0
```
