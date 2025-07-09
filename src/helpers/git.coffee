import { $ } from "zx"

Git =

  isClean: ->
    try
      await $"git diff-index --quiet HEAD"
      true
    catch error      
      false

  getLastCommit: ( path ) ->
    ( await $"git -C #{ path } log -1 --date=iso-strict --pretty=format:'%cd'" )
      .text()
      .trim()
    
  commit: ( message ) -> 
    $"git add -A . && git commit -m #{ message }"

export { Git }