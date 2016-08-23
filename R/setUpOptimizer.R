#' @title
#' Generate an optimizer object.
#'
#' @description
#' Creates an object of type \code{noir_optimizer}.
#'
#' @seealso \code{\link{noir}}
#'
#' @param class [\code{character(1)}]\cr
#'   ID, i.e., short name, of the optimizer to create.
#' @param ... [any]\cr
#'   Further parameters for the optimizer.
#'   If none provided, the default will be used. Later on, one can set the parameters
#'   in the \code{\link{noir}} function.
#' @return [\code{noir_optimizer}]
#' @export
setUpOptimizer = function(class, ...) {
	builder = getS3method("registerOptimizer", class = class)
  #FIXME: catch failure
	optimizer = do.call(builder, list())
  optimizer = setOptimizerParams(optimizer, ...)
  return(optimizer)
}
