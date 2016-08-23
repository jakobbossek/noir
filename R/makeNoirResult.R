makeSingleObjectiveNoirResult = function(best.param, best.value, optimizer.id, optimizer, original.result) {
  makeS3Obj(
    best.param = best.param,
    best.value = best.value,
    optimizer.id = optimizer.id,
    optimizer = optimizer,
    original.result = original.result,
    classes = "noir_result"
  )
}
