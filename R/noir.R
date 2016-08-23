#' @title
#' Run an optimizer on an objective function.
#'
#' @description
#' Expects an \code{noir_optimizer} and a \code{smoof_function} and applies the
#' optimizer to the function.
#'
#' @param optimizer [\code{noir_optimizer} | \code{character(1)}]\cr
#'   Noir optimizer or string short name of an optimizer.
#' @param obj.fn [\code{smoof_function}]\cr
#'   Objective function.
#' @param ... [any]\cr
#    User-defined parameter settings for the optimizer.
#' @return [\code{noir_result}]
#' @examples
#' library(smoof)
#' obj.fn = smoof::makeSphereFunction(2L)
#'
#' # setting up the optimizer by hand
#' optimizer = setUpOptimizer("neldermead")
#' res = noir(optimizer, obj.fn, alpha = 1.5)
#'
#' # alternatively pass the string representation of the optimizer
#' res = noir("neldermead", obj.fn, alpha = 1.5)
#' @export
noir = function(optimizer, obj.fn, ...) {
  if (is.character(optimizer)) {
    optimizer = setUpOptimizer(optimizer)
  }
  assertClass(optimizer, "optimizer")
  assertClass(obj.fn, "smoof_function")
  hyper.par.set = optimizer$hyper.par.set
  final.pars = getFinalParameters(optimizer, obj.fn, ...)
  args = list(optimizer = optimizer, obj.fn = obj.fn)
  args = c(args, final.pars)
  do.call(runOptimizer, args)
}
