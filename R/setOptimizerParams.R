#' Set parameters of an optimizer.
#'
#' @param optimizer [\code{noir_optimizer}]\cr
#'   Optimizer object.
#' @param ... [any]\cr
#'   Parameters to set.
#' @return [\code{noir_optimizer}] with modified parameters.
#' @examples
#' optimizer = setUpOptimizer("neldermead")
#' optimizer = setOptimizerParams(optimizer, alpha = 3.1, maxit = 1000)
#' @export
setOptimizerParams = function(optimizer, ...) {
  assertClass(optimizer, classes = "optimizer")
  user.par.values = list(...)
  print(user.par.values)
  print(names(user.par.values))
  print("---")
  assertList(user.par.values, names = "named")
  user.par.names = names(user.par.values)

  # check for invalid parameter names
  stopOnUnknownParams(user.par.names, optimizer$hyper.par.set)

  # set/overwrite parameters
  for (par.name in user.par.names) {
    optimizer = setOptimizerParam(optimizer, par.name, user.par.values[[par.name]])
  }

  return(optimizer)
}

# Helper to check and set a single optimizer parameter.
#
# @param optimizer [\code{noir_optimizer}]\cr
#   Optimizer object.
# @param par.name [\code{character(1)}]\cr
#   Parameter name.
# @param par.value [any]\cr
#   Corresponding parameter value.
# @return [\code{noir_optimizer}] Modified optimizer.
setOptimizerParam = function(optimizer, par.name, par.value) {
  if (!isFeasible(optimizer$hyper.par.set$pars[[par.name]], par.value)) {
    stopf("Infeasible value for parameter '%s'.", par.name)
  }
  optimizer$par.values[[par.name]] = par.value
  return(optimizer)
}
