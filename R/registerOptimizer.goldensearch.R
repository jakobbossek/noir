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

runOptimizer.goldensearch = function(optimizer, obj.fn) {
	#FIXME: need to load the dependent packages
	hyper.par.set = optimizer$hyper.par.set
	par.set = getParamSet(obj.fn)
	par.values = getDefaults(hyper.par.set)
	#FIXME: user should have the possibility to pass par.set which overrides defaults
	#FIXME: we must check all the provides parameters against the par.set
	result = optimize(f = obj.fn, interval = c(getLower(par.set), getUpper(par.set)), tol = par.values[["tol"]])
	#FIXME: noir result object needed. Think about neccessary properties and differnece 
	#between single-obj. and multi-obj. result
	result
}