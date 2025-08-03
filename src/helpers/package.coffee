import { $ } from "dax-sh"
import Zephyr from "@dashkite/zephyr"
import { Git } from "./git"

Pkg =

  install: -> $"pnpm i"

  update: -> $"pnpm up"

  localVersion: ->
    # make sure we don't get a cached version, please
    Zephyr.invalidate "package.json"
    pkg = await Zephyr.read "package.json"
    pkg.version

  version: ( key ) ->
    try
      await $"pnpm view #{ key } version"
        .quiet()
        .text()
    catch
      undefined
  
  specifier: ( dependency ) ->
    { type } = await Release.getSpecifier dependency.key
    version = await dependency.getPublishedVersion()
    switch type
      when "range"
        "^#{ version }"
      else version

  modified: ( key ) ->
    try
      version = await Pkg.version key
      timestamps = await $"pnpm view #{ key } time --json"
        .json()
      timestamps[ version ]
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
