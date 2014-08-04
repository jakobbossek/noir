runOptimizer = function(optimizer, fn) {
	assertClass(fn, "otf_function")
	UseMethod("runOptimizer")
}