stdout = ( result ) -> ( await result ).toString()

success = ( result ) ->
  result = await result
  if result.exitCode == 0
    result
  else
    throw new Error result.toString()

export { stdout, success }