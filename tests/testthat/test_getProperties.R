context("getProperties")

test_that("getProperties", {
  optimizer = setUpOptimizer("goldensearch")
  expect_character(getProperties(optimizer), unique = TRUE, any.missing = FALSE, all.missing = FALSE)
})
