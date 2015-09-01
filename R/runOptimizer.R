runOptimizer = function(optimizer, fn, ...) {
	assertClass(fn, "smoof_function")
	UseMethod("runOptimizer")
}
