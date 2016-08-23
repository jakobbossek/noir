#' Get ID of an noir optimizer, e.g., short name of an optimizer or the optimizer
#' which produces a result object.
#'
#' @param x [object]\cr
#'   An optimizer or a result object.
#' @return [\code{character(1)}]
#' @export
getNoirID = function(x) {
  UseMethod("getNoirID")
}

#' @export
getNoirID.optimizer = function(x) {
  x$id
}

#' @export
getNoirID.noir_result = function(x) {
  x$algo.id
}
