library(methods)
library(devtools)
library(testthat)
library(gridExtra)
library(cmaes)
library(ParamHelpers)
library(BBmisc)
library(otf)
library(checkmate)
library(ggplot2)

load_all(".")

optimizer = setUpOptimizer("goldensearch")
print(optimizer)

obj.fn = makeSingleObjectiveOTFFunction(
	name = "test function",
	fn = function(x) x^2,
	par.set = makeNumericParamSet(len = 1L, lower = -2L, upper = 2L)
)

res = runOptimizer(optimizer, obj.fn)


