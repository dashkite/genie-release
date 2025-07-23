import { $ } from "dax-sh"
import Zephyr from "@dashkite/zephyr"
import { Git } from "./git"

Pkg =

  install: -> $"pnpm i"

  localVersion: ->
    # make sure we don't get a cached version, please
    Zephyr.invalidate "package.json"
    pkg = await Zephyr.read "package.json"
    pkg.version

  specifier: ( key ) ->
    try
      await $"pnpm view #{ key } version"
        .quiet()
        .text()
    catch
      undefined
  
  modified: ( key ) ->
    try
      specifier = await Pkg.specifier key
      timestamps = await $"pnpm view #{ key } time --json"
        .json()
      timestamps[ specifier ]
    catch
      ( new Date 0 ).toISOString()

  hasChanges: ->
    pkg = await Zephyr.read "package.json"
    key = pkg.name
    if ( lastPublished = await Pkg.modified key )?
      lastCommit = await Git.getLastCommit "."
      lastCommit > lastPublished
    else true

export { Pkg }
