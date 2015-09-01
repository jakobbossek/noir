getFinalParameters = function(optimizer, obj.fn, ...) {
  # get list of passed parameters
  pars = list(...)
  hyper.par.set = optimizer$hyper.par.set

  # check if all parameters are known
  unknown.pars = setdiff(names(pars), getParamIds(hyper.par.set))
  if (length(unknown.pars) > 0L) {
    stopf("You passed unknown parameters '%s'", collapse(unknown.pars))
  }

  def.pars = getDefaults(hyper.par.set)
  final.pars = insert(def.pars, pars)
  return(final.pars)
}
