#' @title
#' Register a new optimizer / optimization algorithm.
#'
#' @description
#' This function is the \dQuote{make} of \pkg{noir}. It is a constructor for
#' \pkg{noir}-optimizers.
#'
#' @param id [\code{character(1)}]\cr
#'   String representation of the optimizer.
#FIXME: later add note, that this is used in runOptimizer() or however I am going
# to call the method ;-)
#' @param class [\code{character(1)}]\cr
#'   Class used internally for the optimizer. Basically this can be equal to \code{id}.
#' @param packages [\code{character}*]\cr
#'   Packages needed to execute the optimizer.
#'   Default is \code{NULL}, i.e., base R is sufficient.
#' @param hyper.par.set [\code{\link[ParamHelpers]{ParamSet}}]\cr
#'   Parameter set defining the algorithm parameters.
#'   See \code{\link[ParamHelpers]{makeParamSet}} for details.
#' @param par.values [\code{list}]\cr
#'   Named list of parameter values.
#'   Default is the empty list.
#' @param objective.type [\code{character(1)}]\cr
#'   One of \dQuote{single-objective} or \dQuote{multi-objective}.
#'   See \code{\link{getAvailableObjectiveTypes}}.
#' @param tags [\code{character(1)}]\cr
#'   Keywords which characterize the properties of the optimizer.
#'   See \code{\link{getSupportedTags}} for a list of available tags.
#'   Default is \code{NULL}, i.e., no tags are assigned.
#' @return [\code{optimizer}] S3 object encapsulating the optimizer.
#' @export
internallyRegisterOptimizer = function(
	id,
	class,
	packages,
	hyper.par.set,
  par.values = list(),
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
  assertList(par.values)
	sapply(hyper.par.set$pars, function(par) assertClass(par, "LearnerParam"))
	makeS3Obj(
		id = id,
		class = class,
		packages = packages,
		hyper.par.set = hyper.par.set,
    par.values = list(),
		objective.type = objective.type,
		tags = tags,
		classes = c("optimizer")
	)
}

print.optimizer = function(x, ...) {
	catf("R optimizer '%s'", x$id)
	catf("Supports %s target functions.", x$objective.type)
	catf("#Parameters: %i", getParamNr(x$hyper.par.set, devectorize = FALSE))
}
