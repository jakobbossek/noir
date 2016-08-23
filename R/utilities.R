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
  pars = list(...)

  # get parameter descriptions
  hyper.par.set = optimizer$hyper.par.set

  # check if all parameters are known
  unknown.pars = setdiff(names(pars), getParamIds(hyper.par.set))
  if (length(unknown.pars) > 0L) {
    stopf("You passed unknown parameters '%s'", collapse(unknown.pars))
  }

  # get defaults ...
  def.pars = getDefaults(hyper.par.set)

  # ... and eventually replace defaults with user-defined settings
  final.pars = insert(def.pars, pars)
  return(final.pars)
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
