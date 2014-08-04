setUpOptimizer = function(class) {
	builder = getS3method("registerOptimizer", class = class)
	do.call(builder, list())
}