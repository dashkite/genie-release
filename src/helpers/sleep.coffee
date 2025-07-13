sleep = (interval) ->
  new Promise (resolve) -> setTimeout resolve, interval

export { sleep }