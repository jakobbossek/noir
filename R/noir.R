#' @title
#' Run an optimizer on an objective function.
#'
#' @description
#' Expects an \code{noir_optimizer} and a \code{smoof_function} and applies the
#' optimizer to the function.
#'
#' @param optimizer [\code{noir_optimizer}]\cr
#'   Noir optimizer.
#' @param obj.fn [\code{smoof_function}]\cr
#'   Objective function.
#' @param ... [any]\cr
#    User-defined parameter settings for the optimizer.
#' @return [\code{noir_result}]
#' @examples
#' optimizer = setUpOptimizer("neldermead")
#' res = noir(optimizer, smoof::makeSphereFunction(2L), alpha = 1.5)
#' @export
noir = function(optimizer, obj.fn, ...) {
  assertClass(optimizer, "optimizer")
  assertClass(obj.fn, "smoof_function")
  hyper.par.set = optimizer$hyper.par.set
  final.pars = getFinalParameters(optimizer, obj.fn, ...)
  args = list(optimizer = optimizer, obj.fn = obj.fn)
  args = c(args, final.pars)
  do.call(runOptimizer, args)
}
