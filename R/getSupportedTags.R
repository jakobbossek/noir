#' Returns currently valid tags.
#'
#' @return [\code{character}] Vector of possible tags.
#' @export
getSupportedTags = function() {
	#FIXME: split this up in type of solver and supported types?
	c("numeric", "mixed", "factors", "discrete", "stochastic", "deterministic")
}
