% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/noir.R
\name{noir}
\alias{noir}
\title{Run an optimizer on an objective function.}
\usage{
noir(optimizer, obj.fn, ...)
}
\arguments{
\item{optimizer}{[\code{noir_optimizer} | \code{character(1)}]\cr
Noir optimizer or string short name of an optimizer.}

\item{obj.fn}{[\code{smoof_function}]\cr
Objective function.}

\item{...}{[any]\cr}
}
\value{
[\code{noir_result}]
}
\description{
Expects an \code{noir_optimizer} and a \code{smoof_function} and applies the
optimizer to the function.
}
\examples{
library(smoof)
obj.fn = smoof::makeSphereFunction(2L)

# setting up the optimizer by hand
optimizer = setUpOptimizer("neldermead")
res = noir(optimizer, obj.fn, alpha = 1.5)

# alternatively pass the string representation of the optimizer
res = noir("neldermead", obj.fn, alpha = 1.5)
}

