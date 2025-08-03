import Zephyr from "@dashkite/zephyr"
import { Pkg } from "./package"
import { Dependency } from "./dependency"
import { Git } from "./git"

Dependencies =

  updatePublished: -> 
    await Pkg.update()
    if !( await Git.isClean())
      Git.commit "updated published dependencies"

  updateLocal: ->

    updated = false
    failure = false
    pkg = await Zephyr.read "package.json"

    for type in [ "dependencies", "devDependencies" ]

      for key, specifier of pkg[ type ]
        dependency = Dependency.make key, specifier
        if dependency.isLocal()
          if await dependency.canUpdate()
            try
              await dependency.update()
              updated = true
            catch error
              console.error error
              failure = true
          else
            failure = true

    if updated
      await Git.commit "updated local dependencies"

    # if we couldn't update them all, throw b/c release failed
    if failure
      throw new Error "genie-release: 
        unable to update local dependencies"

export { Dependencies }
