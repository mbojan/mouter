context("Testing asdf conversion without names")

# Some matrices and arrays
m <- matrix(1:12, 3, 4)
dims <- c(2,2,3)
a <- array( seq(length.out = prod(dims)), dim=dims)


test_that("asdf gives df with proper rows and columns", {
  d <- asdf(m)
  expect_equal(nrow(d), length(m))
  expect_equal(ncol(d), 3)
  expect_equal(names(d), c(paste0(".dim", 1:2), "n"))

  d <- asdf(a)
  expect_equal(nrow(d), prod(dim(a)))
  expect_equal(ncol(d), 4)
  expect_equal(names(d), c(paste0(".dim", 1:3), "n"))
})


test_that("asdf results can be converted back", {
  d <- asdf(m)
  expect_equivalent(
    with(d, tapply(n, list(.dim1, .dim2), sum)),
    m
  )

  d <- asdf(a)
  expect_equivalent(
    with(d, tapply(n, list(.dim1, .dim2, .dim3), sum)),
    a
  )
})









context("Testing asdf with complete dimnames")

# Adding some dimnames
dimnames(m) <- list(
  rows = letters[1:nrow(m)],
  cols = seq(1:ncol(m))
)
dimnames(a) <- list(
  d1 = letters[1:dims[1]],
  d2 = 1:dims[2],
  d3 = LETTERS[1:dims[3]]
)


test_that("converted matrix has proper variables", {
  d <- asdf(m, add_dimnames = TRUE)
  expect_true(
    all(c("rows", "cols", "n") %in% names(d))
  )
  expect_true(
    all( c("d1", "d2", "d3") %in% names(asdf(a, add_dimnames=TRUE)) )
  )
})


test_that("asdf results can be converted back", {
  d <- asdf(m, add_dimnames=TRUE)
  expect_equivalent(
    with(d, tapply(n, list(rows, cols), sum)),
    m
  )

  d <- asdf(a, add_dimnames=TRUE)
  expect_equivalent(
    with(d, tapply(n, list(d1, d2, d3), sum)),
    a
  )
})







context("Testing asdf with incomple/partial dimnames")



# Redefining dimnames
dimnames(m) <- list(
  letters[1:nrow(m)],
  cols = seq(1:ncol(m))
)
dimnames(a) <- list(
  d1 = NULL,
  d2 = 1:dims[2],
  LETTERS[1:dims[3]]
)


test_that("converted matrix has proper variables", {
  d <- asdf(m, add_dimnames = TRUE)
  expect_equal(
    c(".dim1", ".dim2", "n", "Var1", "cols"),
    names(d)
  )
  expect_equal(
    c(paste0(".dim", 1:3), "n", "d1", "d2", "Var3"),
    names(asdf(a, add_dimnames=TRUE))
  )
})
