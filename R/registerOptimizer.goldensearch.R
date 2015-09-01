registerOptimizer.goldensearch = function() {
	addClasses(internallyRegisterOptimizer(
		id = "goldensearch",
		class = "goldensearch",
		packages = c("base"),
		hyper.par.set = makeParamSet(
			makeNumericLearnerParam("tol", lower = 0, default = .Machine$double.eps^0.25)
		),
		objective.type = "single-objective",
		tags = c("numeric", "deterministic")
	), classes = c("goldensearch"))
}

runOptimizer.goldensearch = function(optimizer, obj.fn, ...) {
  #FIXME: need to load the dependent packages
  pars = getFinalParameters(optimizer, obj.fun, ...)
	par.set = getParamSet(obj.fn)
	result = optimize(f = obj.fn, interval = c(getLower(par.set), getUpper(par.set)), tol = pars[["tol"]])
	#FIXME: noir result object needed. Think about neccessary properties and differnece
	#between single-obj. and multi-obj. result
	return(result)
}
