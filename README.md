# `mouter()`: a generalization of `outer()`

[![Build Status](https://travis-ci.org/mbojan/mouter.png?branch=master)](https://travis-ci.org/mbojan/mouter)
[![Build Status](https://ci.appveyor.com/api/projects/status/jx5l79fg7pqbdj9o?svg=true)](https://ci.appveyor.com/project/mbojan/mouter)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/mouter?color=2ED968)](http://cranlogs.r-pkg.org/)
[![cran version](http://www.r-pkg.org/badges/version/mouter)](https://cran.r-project.org/package=mouter)




Function `mouter::mouter()` generalizes (a bit) `base::outer()` so that it can be conviniently used to build joint frequency distributions from several marginal distributions.

## Examples

We call `mouter` with a collection of vertices and arrays. They will correspond to margins. Say:



```r
# As an array
a <- mouter(
  A = c(a=1, b=2) / 3,
  M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
  B = c(c=2, d=3) / 5,
  retval="a"
)

str(a)
```

```
##  num [1:2, 1:2, 1:2, 1:2] 0.0133 0.0267 0.0267 0.0533 0.04 ...
##  - attr(*, "dimnames")=List of 4
##   ..$ A: chr [1:2] "a" "b"
##   ..$ D: chr [1:2] "e" "f"
##   ..$ E: chr [1:2] "g" "h"
##   ..$ B: chr [1:2] "c" "d"
```

Alternatively, `mouter` can return a data frame:


```r
# Data frame
mouter(
  A = c(a=1, b=2) / 3,
  M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
  B = c(c=2, d=3) / 5,
  retval="df"
)
```

```
##    A D E B          n
## 1  a e g c 0.01333333
## 2  b e g c 0.02666667
## 3  a f g c 0.02666667
## 4  b f g c 0.05333333
## 5  a e h c 0.04000000
## 6  b e h c 0.08000000
## 7  a f h c 0.05333333
## 8  b f h c 0.10666667
## 9  a e g d 0.02000000
## 10 b e g d 0.04000000
## 11 a f g d 0.04000000
## 12 b f g d 0.08000000
## 13 a e h d 0.06000000
## 14 b e h d 0.12000000
## 15 a f h d 0.08000000
## 16 b f h d 0.16000000
```




## Installation


```r
devtools::install_github("mbojan/mouter")
```
