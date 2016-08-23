context("main entry point: the noir function")

test_that("noir call works as expected", {
  # our test function
  obj.fn = makeSphereFunction(dimensions = 2L)

  expect_found_optimum = function(res) {
    expect_numeric(res$best.param, len = 2L, lower = -0.005, upper = 0.005, any.missing = FALSE, all.missing = FALSE)
    expect_number(res$best.value, lower = 0, upper = 0.001)
  }

  expect_found_optimum(noir(setUpOptimizer("neldermead"), obj.fn))
  expect_found_optimum(noir("neldermead", obj.fn))
})
