import { metaclass } from "@dashkite/joy/metaclass"
import { Git } from "./git"
import { Pkg } from "./package"

# See ticket #1
# https://github.com/dashkite/genie-release/issues/1

class Dependency

  @make: ( key, specifier ) ->
    scope = undefined
    name = key
    if key.startsWith "@"
      [ scope, name ] = name[1..].split "/"
    Object.assign ( new @ ),
      { key, scope, name, specifier }

  isLocal: -> @specifier.startsWith "link:"

  path: -> if @isLocal then @specifier[5..]

  canUpdate: ->
    if @isLocal() && ( await @getPublishedSpecifier())?
      if ( lastPublished = await Pkg.modified @key )?
        lastCommit = await Git.getPenultimateCommit @path()
        lastCommit <= lastPublished
      else false
    else false

  getPublishedSpecifier: -> Pkg.specifier @key

export { Dependency }


