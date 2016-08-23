#' Check if optimizer has certain properties.
#'
#' @param optimizer [\code{noir_optimizer}]\cr
#'   The optimizer.
#' @param properties [\code{character}]\cr
#'   Properties/tags to check for.
#'   If multiple properties are are passed it is checked whether the optimizer
#'   has all of them.
#' @return [\code{logical(1)}]
#' @export
hasProperties = function(optimizer, properties) {
  assertSubset(properties, choices = getSupportedTags(), empty.ok = TRUE)
  UseMethod("hasProperties")
}

#' @export
hasProperties.optimizer = function(optimizer, properties) {
  BBmisc::isSubset(properties, getProperties(optimizer))
}

#FIXME: later add methods for wrapped optimizers as well!

