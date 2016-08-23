# Get final parameter setting for an optimizer.
#
# @param optimizer [noir_optimizer]
#   The optimizer object.
# @param obj.fn [smoof_function]
#   Smoof objective function.
# @param ... [any]
#   User-defined parameter settings for the optimizer.
# @return [list] Named list parameter settings.
getFinalParameters = function(optimizer, obj.fn, ...) {
  # get list of passed parameters
  user.par.values = list(...)

  # get parameter values already assigned to optimizer by calling either
  # setUpOptimzer(...) or setOptimizerParameters(...)
  par.values = optimizer$par.values

  # get defaults
  default.par.values = getDefaults(optimizer$hyper.par.set)

  # glue it all together
  par.values = insert(par.values, user.par.values)

  final.par.values = insert(default.par.values, par.values)

  optimizer = do.call(setOptimizerParams, c(list(optimizer), final.par.values))

  # ... and eventually replace defaults with user-defined settings
  return(final.par.values)
}

# Convert list of parameters into special control object.
#
# Many optimization algorithms need to pass (some) parameters wrapped in a
# special control object, e.g., most often a simple named list.
# This helper functions applies the control-structure constructor to a set
# of parameters.
#
# @param wrap.fun [function]
#   Function to use for control object construction.
# @param ... [any]
#   Parameters for the optimizer control object.
# @return [object] Corresponding control object.
convertArgsToControl = function(wrap.fun, ...) {
  dots = match.call()$...
  do.call(wrap.fun, list(...))
}

# Check for invalid parameter names and print error message.
#
# @param ns [character]
#   Given names.
# @param par.set [ParamHelpers::ParamSet]
#   Parameter set.
# @return Nothing
stopOnUnknownParams = function(ns, par.set) {
  par.names = getParamIds(par.set)
  if (!isSubset(ns, par.names)) {
    unknown.par.names = setdiff(ns, par.names)
    stopf("The following parameters are unknown: %s", collapse(unknown.par.names))
  }
  invisible(NULL)
}
