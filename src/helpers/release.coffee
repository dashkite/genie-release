import Zephyr from "@dashkite/zephyr"

Release =

  getType: ->
    if ( release = await Zephyr.read "release.yaml" )?
      release.type
    else if process.env.release?
      process.env.release
    else
      throw new Error "genie-release: unable to determine release type"

export { Release }