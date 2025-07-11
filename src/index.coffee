import { $ } from "zx"
import { Release, Dependencies, Git, Pkg } from "./helpers"

# $.quiet = true

export default ( Genie ) ->

  Genie.define "release:version", ( version ) ->
    [ version, tag ] = version.split "-"
    switch version
      when "alpha", "beta"
        $ "npm version prerelease --preid #{ version }"
      when "major", "minor", "patch"
        unless tag?
          $ "npm version #{ version }"
        else
          $ "npm version pre#{ version } --preid #{ tag }"
      else
        throw new Error "genie-release: 
          unknown version type: #{ version }"

  Genie.define "release:publish", -> $ "npm publish --access public"

  Genie.define "release:push", -> $ "git push --follow-tags"

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

