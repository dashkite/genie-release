import Zephyr from "@dashkite/zephyr"

Specifier =
  default: type: "range"

Release =

  stable: ->
    switch process.env.stable?.toLowerCase()
      when "yes", "true" then true
      else false

  getType: ->
    if ( release = await Zephyr.read "release.yaml" )?
      release.type
    else if process.env.release?
      process.env.release
    else
      throw new Error "genie-release: unable to determine release type"

  getSpecifier: ( key ) ->
    if ( release = await Zephyr.read "release.yaml" )?
      release.specifiers[ key ] ? Specifier.default
    else Specifier.default

  force: ->
    switch process.env.force?.toLowerCase()
      when "yes", "true" then true
      else false

export { Release }