#' Converting arrays to tibbles with or without dimnames
#'
#' This function returns a "tidy" version of an array: a row per cell with first
#' variables identifying the dimensions.
#'
#' @param x array
#' @param responseName character, name of the variable containing cell values
#' @param add_dimnames logical, should dimnames be appended to the result
#' @param retval character, class of returned result, \code{tibble} or \code{df} for a data frame
#' @param ... other arguments passed to \code{\link{provideDimnames}}
#'
#' @return A tibble or data frame, as determined by \code{retval}.
#' @export
asdf <- function(x, responseName="n", add_dimnames=FALSE,
                 retval=c("tibble", "df"), ...) {
  stopifnot(is.array(x))
  retval <- match.arg(retval)
  # construct df building call
  ex <- quote(
    data.frame(
      do.call("expand.grid", c(
        structure(
          lapply(dim(x), seq),
          names = paste0(".dim", seq(1, length(dim(x))))
          ),
        KEEP.OUT.ATTRS = FALSE,
        stringsAsFactors=FALSE
      ) ),
      Freq = c(x) )
  )
  names(ex)[3L] <- responseName
  rval <- eval(ex)
  if(add_dimnames) {
    ex <- quote(
      data.frame(do.call("expand.grid", c(
        dimnames(provideDimnames(x, ...)),
        KEEP.OUT.ATTRS = FALSE,
        stringsAsFactors=FALSE
      ) ) )
    )
    dnames <- eval(ex)
    rval <- cbind(rval, dnames)
  }

  switch(retval,
         tibble = tibble::as_data_frame(rval),
         df = rval
  )
}



if(FALSE) {
  a <- array(1:8, dim=c(2,2,2), dimnames=list(r=letters[1:2], A=NULL, B=LETTERS[1:2]))
  asdf( a )
  asdf( as.table(a) )
  asdf(a, add_dimnames = TRUE)
}

