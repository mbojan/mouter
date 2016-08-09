#' A generalization of base::outer()
#'
#' Given a list of vector or arrays applie \code{\link{outer}} consecutively.
#'
#' @param ... vectors or matrices
#' @param retval character, whether to return a data frame (\code{"df"}) or array (\code{"array"})
#' @param freq_var character scalar, when returning a data frame this will be the name of the variable containing cell values
#'
#' Given the list of vectors and/or arrays \code{\link{outer}} is used to
#' combine the elements one-by-one (using \code{\link{Reduce}}).
#'
#' @return
#' Depending on the value of \code{retval}, an array or a data frame with the
#' outer product of elements supplied through \code{...}.
#'
#' @export
# @example man-roxygen/mouter.R

mouter <- function(...,
                   retval=c("df", "array"),
                   freq_var="n") {
  retval <- match.arg(retval)
  args <- list(...)

  # Sanity checks
  is_atom <- sapply(args, is.atomic)
  if(any(!is_atom))
    stop("elements ", paste(which(!is_atom), collapse=", "), " are not atomic")
  is_num <- sapply(args, is.numeric)
  if(any(!is_num))
    stop("elements ", paste(which(!is_num), collapse=", "), " are not numeric")

  # Reduce!
  rval <- Reduce(outer, args)

  # Fix variable names
  var_names <- function(l) {
    lapply( seq(along=l), function(i) {
      d <- dim(l[[i]])
      if(length(d) > 1) return(names(dimnames(l[[i]])))
      else return(names(l[i]))
    } )
  }
  names(dimnames(rval)) <- unlist(var_names(args))

  # Return
  if(retval == "df") {
    rval <- as.data.frame(as.table(rval), stringsAsFactors=FALSE)
    names(rval)[length(rval)] <- freq_var
  }
  return(rval)
}
