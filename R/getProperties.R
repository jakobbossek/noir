#' Return properties/tags of an optimizer.
#'
#' @param optimizer [\code{noir_optimizer}]\cr
#'   The optimizer.
#' @return [\code{character}] Character vector of properties.
#' @export
getProperties = function(optimizer) {
  UseMethod("getProperties")
}

#' @export
getProperties.optimizer = function(optimizer) {
  if (is.null(optimizer$tags))
    return(character(0))
  return(optimizer$tags)
}

#FIXME: later add methods for wrapped optimizers as well!

