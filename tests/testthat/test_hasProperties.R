context("hasProperties")

test_that("hasProperties", {
  optimizer = setUpOptimizer("goldensearch")
  expect_true(hasProperties(optimizer, "numeric"))
  expect_true(hasProperties(optimizer, c("1D", "numeric")))
  expect_false(hasProperties(optimizer, "stochastic"))
})
