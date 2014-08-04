# Returns currently valid tags.
getSupportedTags = function() {
	#FIXME: split this up in type of solver and supported types?
	c("numeric", "mixed", "factors", "discrete", "stochastic", "deterministic")
}