
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
#> [1] -0.109  0.512 -0.786 -0.175  1.128
```

### `vap_chr()`

Iterate over input and return character.

Also, useful shortcut: use formulas with `.x`, just like with the
[**{purrr}**](https://purrr.tidyverse.org) package

``` r
## character
vap_chr(letters[1:3], ~ paste0(.x, "."))
#> [1] "a." "b." "c."
```

### `vap_lgl()`

Iterate over input and return logical.

``` r
## logical
vap_lgl(letters[1:3], ~ .x %in% c("a", "e", "i", "o", "u"))
#> [1]  TRUE FALSE FALSE
```

### `lap()`

Iterate over input and return list(s).

``` r
## list of strings
lap(letters[1:3], ~ paste0(.x, "."))
#> [[1]]
#> [1] "a."
#> 
#> [[2]]
#> [1] "b."
#> 
#> [[3]]
#> [1] "c."

## list of columns
lap(mtcars[1:3, 1:3], as.integer)
#> $mpg
#> [1] 21 21 22
#> 
#> $cyl
#> [1] 6 6 4
#> 
#> $disp
#> [1] 160 160 108
```

### `dap()`

Iterate over input and return list(s).

``` r
## round columns
dapc(mtcars[1:3], ~ round(.x, 2))
#>                      mpg cyl  disp
#> Mazda RX4           21.0   6 160.0
#> Mazda RX4 Wag       21.0   6 160.0
#> Datsun 710          22.8   4 108.0
#> Hornet 4 Drive      21.4   6 258.0
#> Hornet Sportabout   18.7   8 360.0
#> Valiant             18.1   6 225.0
#> Duster 360          14.3   8 360.0
#> Merc 240D           24.4   4 146.7
#> Merc 230            22.8   4 140.8
#> Merc 280            19.2   6 167.6
#> Merc 280C           17.8   6 167.6
#> Merc 450SE          16.4   8 275.8
#> Merc 450SL          17.3   8 275.8
#> Merc 450SLC         15.2   8 275.8
#> Cadillac Fleetwood  10.4   8 472.0
#> Lincoln Continental 10.4   8 460.0
#> Chrysler Imperial   14.7   8 440.0
#> Fiat 128            32.4   4  78.7
#> Honda Civic         30.4   4  75.7
#> Toyota Corolla      33.9   4  71.1
#> Toyota Corona       21.5   4 120.1
#> Dodge Challenger    15.5   8 318.0
#> AMC Javelin         15.2   8 304.0
#> Camaro Z28          13.3   8 350.0
#> Pontiac Firebird    19.2   8 400.0
#> Fiat X1-9           27.3   4  79.0
#> Porsche 914-2       26.0   4 120.3
#> Lotus Europa        30.4   4  95.1
#> Ford Pantera L      15.8   8 351.0
#> Ferrari Dino        19.7   6 145.0
#> Maserati Bora       15.0   8 301.0
#> Volvo 142E          21.4   4 121.0

## round columns
dapc(mtcars[1:3], round, 3)
#>                      mpg cyl  disp
#> Mazda RX4           21.0   6 160.0
#> Mazda RX4 Wag       21.0   6 160.0
#> Datsun 710          22.8   4 108.0
#> Hornet 4 Drive      21.4   6 258.0
#> Hornet Sportabout   18.7   8 360.0
#> Valiant             18.1   6 225.0
#> Duster 360          14.3   8 360.0
#> Merc 240D           24.4   4 146.7
#> Merc 230            22.8   4 140.8
#> Merc 280            19.2   6 167.6
#> Merc 280C           17.8   6 167.6
#> Merc 450SE          16.4   8 275.8
#> Merc 450SL          17.3   8 275.8
#> Merc 450SLC         15.2   8 275.8
#> Cadillac Fleetwood  10.4   8 472.0
#> Lincoln Continental 10.4   8 460.0
#> Chrysler Imperial   14.7   8 440.0
#> Fiat 128            32.4   4  78.7
#> Honda Civic         30.4   4  75.7
#> Toyota Corolla      33.9   4  71.1
#> Toyota Corona       21.5   4 120.1
#> Dodge Challenger    15.5   8 318.0
#> AMC Javelin         15.2   8 304.0
#> Camaro Z28          13.3   8 350.0
#> Pontiac Firebird    19.2   8 400.0
#> Fiat X1-9           27.3   4  79.0
#> Porsche 914-2       26.0   4 120.3
#> Lotus Europa        30.4   4  95.1
#> Ford Pantera L      15.8   8 351.0
#> Ferrari Dino        19.7   6 145.0
#> Maserati Bora       15.0   8 301.0
#> Volvo 142E          21.4   4 121.0
```
