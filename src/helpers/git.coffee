import { $ } from "zx"

Git =

  isClean: ->
    try
      await $"git diff-index --quiet HEAD"
      true
    catch error      
      false

  # we use -2 here to get the next to last (penultimate)
  # commit, since we commit the tag right after publishing
  getPenultimateCommit: ( path ) ->
    ( await $"git -C #{ path } log -2 --date=iso-strict --pretty=format:'%cd'" )
      .text()
      .trim()
    
  commit: ( message ) -> 
    $"git add -A . && git commit -m #{ message }"

export { Git }