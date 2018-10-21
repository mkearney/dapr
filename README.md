
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

## Mapping functions

### `vap_dbl()`

Iterate over input and return double.

``` r
## double
vap_dbl(rnorm(5), round, 3)
#> [1] -0.601 -0.932  1.657 -1.416  0.189
```

### `vap_chr()`

Iterate over input and return character.

Also, useful shortcut: use formulas with `.x`, just like with the
[**{purrr}**](https://purrr.tidyverse.org) package

``` r
## character
vap_chr(letters[1:5], ~ paste0(.x, "."))
#> [1] "a." "b." "c." "d." "e."
```

### `vap_lgl()`

Iterate over input and return logical.

``` r
## logical
vap_lgl(letters[1:5], ~ .x %in% c("a", "e", "i", "o", "u"))
#> [1]  TRUE FALSE FALSE FALSE  TRUE
```

### `lap()`

Iterate over input and return list(s).

``` r
## list of strings
lap(letters[1:5], ~ paste0(.x, "."))
#> [[1]]
#> [1] "a."
#> 
#> [[2]]
#> [1] "b."
#> 
#> [[3]]
#> [1] "c."
#> 
#> [[4]]
#> [1] "d."
#> 
#> [[5]]
#> [1] "e."

## list of columns
lap(mtcars[1:5, 1:5], as.integer)
#> $mpg
#> [1] 21 21 22 21 18
#> 
#> $cyl
#> [1] 6 6 4 6 8
#> 
#> $disp
#> [1] 160 160 108 258 360
#> 
#> $hp
#> [1] 110 110  93 110 175
#> 
#> $drat
#> [1] 3 3 3 3 3
```
