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
#' @return [\code{noir_optimizer}]
#' @export
setUpOptimizer = function(class) {
	builder = getS3method("registerOptimizer", class = class)
	do.call(builder, list())
}
