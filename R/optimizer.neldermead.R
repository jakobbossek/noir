registerOptimizer.neldermead = function() {
  par.set = makeNoirOptimParSet()
  par.set = dropParams(par.set, drop = c("lower", "upper", "lmm", "factr", "pgtol", "temp", "tmax"))

  addClasses(internallyRegisterOptimizer(
    id = "neldermead",
    class = "neldermead",
    packages = "base",
    hyper.par.set = par.set,
    objective.type = "single-objective",
    tags = c("numeric", "stochastic", "ND")
  ), classes = "neldermead")
}

runOptimizer.neldermead = function(optimizer, obj.fn, par = NULL, gr = NULL, lower, upper,
  fnscale, parscale, ndeps, maxit, abstol = NULL, reltol, alpha, beta, gamma, REPORT,
  type, hessian, ...) {
  # wrap some parameters in control object (simple named list)
  optim.control = convertArgsToControl(list, fnscale, parscale, ndeps, maxit, abstol,
    reltol, alpha, beta, gamma, REPORT, type)
  fn.par.set = ParamHelpers::getParamSet(obj.fn)
  n.dim = getNumberOfParameters(obj.fn)

  #FIXME: list is not named!!! -> no effect
  print(optim.control)

  # build argument list for optimizer call
  pars = list(fn = obj.fn,
    #FIXME: this is ugly and not general enough!
    par = coalesce(par, sapply(seq_len(n.dim), function(i) runif(1L, min = getLower(fn.par.set)[i], max = getUpper(fn.par.set)[i]))),
    gr = gr,
    control = optim.control,
    hessian = hessian)

  #FIXME: add options to handle errors
  # finally call the optimizer
  result = do.call(optim, pars)

  return(makeSingleObjectiveNoirResult(result$par, result$value, getNoirID(optimizer), optimizer, result))
}

# Helper function which creates the parameter set of the stats::optim function.
#
# The majority is shared by all algorithms offered by optim, e.g., par, maxit,
# but some are specific to certain solvers, e.g., temp and tmax for simulated
# annlealing. Moreover, the defaults vary by method, e.g., maxit = 100 for
# derivative-free methods and maxit = 10000 for SANN.
#
# This object is created by all noir optimizers which call stats::optim.
# Some off the parameters are then dropped.
#
# @return [ParamHelpers::ParamSet]
makeNoirOptimParSet = function() {
  makeParamSet(
    makeNumericVectorLearnerParam("par"), # initial x
    makeFunctionLearnerParam("gr"), # optional gradient information
    makeNumericLearnerParam("lower"), #FIXME: only for L-BFGS-B or Brent
    makeNumericLearnerParam("upper"),
    makeNumericLearnerParam("fnscale", default = 1), #FIXME: 0 is infeasible
    makeNumericLearnerParam("parscale", default = 1),
    makeNumericLearnerParam("ndeps", default =  1e-3),
    makeIntegerLearnerParam("maxit", default = 500), #FIMXE: 100 for derivative based methods, 10000 for SANN
    makeNumericLearnerParam("abstol"),
    makeNumericLearnerParam("reltol", default = sqrt(.Machine$double.eps)),
    makeNumericLearnerParam("alpha", default = 1.0),
    makeNumericLearnerParam("beta", default = 0.5),
    makeNumericLearnerParam("gamma", default = 2.0),
    makeIntegerLearnerParam("REPORT", lower = 0, default = 10), # only if trace is positive, default 10 for bfgs, lbfgs-b and 100 for sann
    makeIntegerLearnerParam("type", lower = 1, upper = 3, default = 1), # default not mentioned in docs -.-
    makeIntegerLearnerParam("lmm", lower = 1, default = 5),
    makeNumericLearnerParam("factr", default = 1e7),
    makeNumericLearnerParam("pgtol", default = 0),
    makeNumericLearnerParam("temp", default = 10),
    makeNumericLearnerParam("tmax", default = 10),
    makeLogicalLearnerParam("hessian", default = FALSE)
  )
}
