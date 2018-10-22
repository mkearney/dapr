
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dapr <img src="man/figures/logo.png" width="160px" align="right" />

[![Build
status](https://travis-ci.org/mkearney/dapr.svg?branch=master)](https://travis-ci.org/mkearney/dapr)
[![CRAN
status](https://www.r-pkg.org/badges/version/dapr)](https://cran.r-project.org/package=dapr)
[![Coverage
Status](https://codecov.io/gh/mkearney/dapr/branch/master/graph/badge.svg)](https://codecov.io/gh/mkearney/dapr?branch=master)

<!--#![Downloads](https://cranlogs.r-pkg.org/badges/dapr)
#![Downloads](https://cranlogs.r-pkg.org/badges/grand-total/dapr)-->

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

Dependency-free purrr-like apply/map/iterate functions

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

## Use

Function names use the convention `*ap()` where **`*`** is the first
letter of output data
    type.

  - <code><span style="font-weight:bold;text-decoration:underline">v</span>ap</code>
    for
    **vectors**
  - <code><span style="font-weight:bold;text-decoration:underline">l</span>ap</code>
    for
    **lists**
  - <code><span style="font-weight:bold;text-decoration:underline">d</span>ap</code>
    for **data frames**

### Vectors

  - **`vap_dbl()`** Iterate and return **numeric** vector.
  - **`vap_int()`** Iterate and return **integer** vector.
  - **`vap_lgl()`** Iterate and return **logical** vector.
  - **`vap_chr()`** Iterate and return **character** vector.

<!-- end list -->

``` r
## create data
set.seed(2018)
d <- replicate(5, rnorm(10), simplify = FALSE)
e <- replicate(5, sample(letters, 10), simplify = FALSE)

## numeric
vap_dbl(d, ~ mean(.x))
#> [1]  0.2693453 -0.5523232  0.0555929 -0.0625326 -0.1118376

## integer
vap_int(d, length)
#> [1] 10 10 10 10 10

## logical
vap_lgl(d, ~ max(.x) > 3)
#> [1] FALSE FALSE FALSE FALSE FALSE

## character
vap_chr(e, paste, collapse = "")
#> [1] "hizjpgcexk" "rbeovimtxh" "ujrimwgvzs" "euwrlytgbj" "qkrhylgmnx"
```

### Lists

  - **`lap()`** Iterate and return a **list** vector.

<!-- end list -->

``` r
## list of strings
lap(e[1:2], ~ paste0(.x, "."))
#> [[1]]
#>  [1] "h." "i." "z." "j." "p." "g." "c." "e." "x." "k."
#> 
#> [[2]]
#>  [1] "r." "b." "e." "o." "v." "i." "m." "t." "x." "h."
```

### Data frames

  - **`dap()`** Iterate (over columns) and return a **data frame**.
  - **`dapc()`** Iterate over **columns**.
  - **`dapr()`** Iterate over **rows**.
  - **`dapc_if()`** Iterate over **columns** meeting logical test.

<!-- end list -->

``` r
## some data
d <- data.frame(
  a = letters[1:3],
  b = rnorm(3),
  c = rnorm(3),
  stringsAsFactors = FALSE
)

## default applies to columns
dap(d[-1], ~ round(.x, 1))
#>      b    c
#> 1 -0.5 -0.1
#> 2 -1.9  1.1
#> 3  0.7 -1.4

## column explicit (same as dap)
dapc(d[-1], ~ round(.x, 2))
#>       b     c
#> 1 -0.50 -0.09
#> 2 -1.87  1.08
#> 3  0.74 -1.36

## rows
dapr(d[-1], round, 3)
#>        b      c
#> 1 -0.499 -0.089
#> 2 -1.869  1.081
#> 3  0.743 -1.365

## IF columns
dapc_if(d, is.numeric, ~ round(.x, 4))
#>   a       b       c
#> 1 a -0.4994 -0.0892
#> 2 b -1.8686  1.0812
#> 3 c  0.7434 -1.3646

## IF rows
dapr_if(d[-1], ~ sum(.x) >= -.7, ~ round(.x, 0))
#>          b        c
#> 1  0.00000  0.00000
#> 2 -1.86861  1.08116
#> 3  1.00000 -1.00000
```
