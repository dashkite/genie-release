import { $ } from "zx"
import { Release, Dependencies, Git, Pkg, success } from "./helpers"

# $.quiet = true

export default ( Genie ) ->

  Genie.define "release:version", ( version ) ->
    [ version, tag ] = version.split "-"
    switch version
      when "alpha", "beta"
        success $"npm version prerelease --preid #{ version }"
      when "major", "minor", "patch"
        unless tag?
          success $"npm version #{ version }"
        else
          success $"npm version pre#{ version } --preid #{ tag }"
      else
        throw new Error "genie-release: 
          unknown version type: #{ version }"

  Genie.define "release:publish", -> 
    await success $"npm publish --access public"
    # confirm that NPM has the right version
    local = await Pkg.localVersion()
    count = 0
    loop
      remote = await Pkg.specifier "."
      break if (( local == remote ) || ( count++ > 10 ))

  Genie.define "release:push", -> success $"git push --follow-tags"
    
  Genie.define "release:update-local-dependencies", ->
    Dependencies.updateLocalDependencies()

  # TODO add dependency on test task
  #      in theory, genie supports optional tasks
  #      but we got an undefined task ('Starting undefined')
  #      and an error:
  #      Cannot read properties of undefined (reading 'initialize')

  Genie.define "release", ( version ) ->

    if await Git.isClean()

      if await Pkg.hasChanges()

        version ?= await Release.getType()

        Genie.run [
          "release:update-local-dependencies"
          "release:version:#{version}"
          "release:publish"
          "release:push"
        ]

    else

      throw new Error "genie-release:
        unable to release because 
        there are uncommitted changes"

