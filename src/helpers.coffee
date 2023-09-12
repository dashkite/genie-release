import { command as exec } from "execa"

sh = ( action, options ) ->
  result = await exec action, 
    { stdout: "inherit", stderr: "inherit", shell: true, options... }
  if result.exitCode != 0
    throw new Error result.stderr
  else result

export { sh }