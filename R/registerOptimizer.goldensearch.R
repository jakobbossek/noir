registerOptimizer.goldensearch = function() {
	addClasses(internallyRegisterOptimizer(
		id = "goldensearch",
		class = "goldensearch",
		packages = c("base"),
		hyper.par.set = makeParamSet(
      makeNumericVectorLearnerParam("interval"),
      makeNumericLearnerParam("lower"),
      makeNumericLearnerParam("upper"),
      makeNumericLearnerParam("tol", lower = 0, default = .Machine$double.eps^0.25, tunable = FALSE),
      makeLogicalLearnerParam("maximum", default = TRUE)
		),
		objective.type = "single-objective",
		tags = c("numeric", "deterministic", "1D")
	), classes = c("goldensearch"))
}

runOptimizer.goldensearch = function(optimizer, obj.fn, ...) {
  #FIXME: need to load the dependent packages
  pars = getFinalParameters(optimizer, obj.fn, ...)
	par.set = getParamSet(obj.fn)
	result = optimize(f = obj.fn, interval = c(getLower(par.set), getUpper(par.set)), tol = pars[["tol"]])
	#FIXME: noir result object needed. Think about neccessary properties and differnece
	#between single-obj. and multi-obj. result
	return(result)
}
