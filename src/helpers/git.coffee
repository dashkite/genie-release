import { $ } from "dax-sh"

Git =

  isClean: ->
    try
      await $"git update-index --refresh && 
        git diff-index --quiet HEAD --"
        .quiet()
      true
    catch error
      false

  getLastCommit: ( path ) ->
    local = await $"git -C #{ path } log -1 
        --date=iso-strict --pretty=format:'%ci'"
        .text()
    ( new Date local ).toISOString()
    
  commit: ( message ) ->
    $"git add -A . && git commit -m #{ message }"

export { Git }