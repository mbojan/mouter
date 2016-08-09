context("Testing basics of mouter()")




# TODO: Future feature
test_that("mouter can be called with a list of vectors/matrices", {
  l <- list(
    A = c(a=1, b=2) / 3,
    M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
    B = c(c=2, d=3) / 5
  )
  # r <- mouter(l)
})






context("Testing mouter()")

test_that("variables have proper names", {
  a <- mouter(
    A = c(a=1, b=2) / 3,
    M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
    B = c(c=2, d=3) / 5,
    retval="a"
  )

  d <- mouter(
    A = c(a=1, b=2) / 3,
    M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
    B = c(c=2, d=3) / 5,
    retval="df"
  )

  expect_identical( names(dimnames(a)), c("A", "D", "E", "B") )

  expect_identical( names(d), c("A", "D", "E", "B", formals(mouter)$freq_var) )

})
