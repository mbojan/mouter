context("mouter() basic usage")



test_that("mouter-to-array works for vectors/matrices without (dim)names", {
  r <- mouter(c(1:2), c(2,1), matrix(1:4, 2, 2), retval="array")
  expect_is(r, "array")
})

test_that("mouter-to-dataframe works for vectors/matrices without (dim)names", {
  r <- mouter(c(1:2), c(2,1), matrix(1:4, 2, 2), retval="df")
  expect_s3_class(r, "data.frame")
})

test_that("mouter-to-tibble works for vectors/matrices without (dim)names", {
  r <- mouter(c(1:2), c(2,1), matrix(1:4, 2, 2), retval="tibble")
  expect_s3_class(r, "tbl_df")
})



# TODO: Future feature #5
test_that("mouter can be called with a list of vectors/matrices", {
  l <- list(
    A = c(a=1, b=2) / 3,
    M = matrix(1:4 / 10, 2, 2, dimnames=list(D=letters[5:6], E=letters[7:8])),
    B = c(c=2, d=3) / 5
  )
  # r <- mouter(l)
})






context("mouter() output consistency")

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

  expect_identical( names(d),
                    c( paste0("Var", seq(1, ncol(d)-1)), formals(mouter)$responseName) )

})
