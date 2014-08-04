internallyRegisterOptimizer = function(
	id,
	class,
	packages,
	hyper.par.set,
	objective.type = "single-objective",
	tags = NULL) {
	assertString(id)
	assertString(class)
	assertChoice(objective.type, choices = getAvailableObjectiveTypes())
	if (!is.null(tags)) {
		assertSubset(tags, choices = getSupportedTags())
	}
	assertCharacter(packages, any.missing = FALSE)
	assertClass(hyper.par.set, "ParamSet")
	sapply(hyper.par.set$pars, function(par) assertClass(par, "LearnerParam"))
	makeS3Obj(
		id = id,
		class = class,
		packages = packages,
		hyper.par.set = hyper.par.set,
		objective.type = objective.type,
		tags = tags,
		classes = c("optimizer")
	)
}

print.optimizer = function(x, ...) {
	catf("R optimizer '%s'", x$id)
	catf("Supports %s target functions.", x$objective.type)
	catf("#Hyper parameters: %i", sum(getParamLengths(x$hyper.par.set)))
}