import Zephyr from "@dashkite/zephyr"
import { Pkg } from "./package"
import { Dependency } from "./dependency"
import { Git } from "./git"

Dependencies =

  updateLocalDependencies: ->

    # first check each local dependency to see if we can
    # update it to a published version

    updated = []
    failure = false
    pkg = await Zephyr.read "package.json"

    for key, specifier of pkg.dependencies
      dependency = Dependency.make key, specifier
      if dependency.isLocal()
        if await dependency.canUpdate()
          updated.push dependency
        else
          failure = true

    # update any we can and commit the changes
    if updated.length > 0
      await Zephyr.update "package.json", ( pkg ) ->
        for dependency in updated
          pkg.dependencies[ dependency.key ] = 
            await dependency.getPublishedSpecifier()
        pkg
      await Pkg.install()
      await Git.commit "updated local dependencies"

    # same but for devDependencies
    updated = []

    for key, specifier of pkg.devDependencies
      dependency = Dependency.make key, specifier
      if dependency.isLocal()
        if await dependency.canUpdate()
          updated.push dependency
        else
          failure = true

    # update any we can and commit the changes
    if updated.length > 0
      await Zephyr.update "package.json", ( pkg ) ->
        for dependency in updated
          pkg.devDependencies[ dependency.key ] = 
            await dependency.getPublishedSpecifier()
        pkg
      await Pkg.install()
      await Git.commit "updated local dev dependencies"

    # if we couldn't update them all, throw b/c release failed
    if failure
      throw new Error "genie-release: 
        unable to update local dev dependencies"

export { Dependencies }