import { $ } from "zx"
import { success } from "./command"

Git =

  isClean: ->
    try
      await $"git diff-index --quiet HEAD"
      true
    catch error      
      false

  getLastCommit: ( path ) ->
    local = ( await success $"git -C #{ path } log -1 
      --date=iso-strict --pretty=format:'%ci'" )
      .text()
      .trim()
    ( new Date local ).toISOString()
    
  commit: ( message ) ->
    success $"git add -A . && git commit -m #{ message }"

export { Git }