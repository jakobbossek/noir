runOptimizer = function(optimizer, obj.fn, ...) {
	assertClass(obj.fn, "smoof_function")
	UseMethod("runOptimizer")
}
