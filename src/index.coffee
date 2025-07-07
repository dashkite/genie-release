import { $ } from "zx"
import { Release, Dependencies } from "./helpers"

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

  Genie.define "release:upgrade-local-dependencies", ->
    await Dependencies.updateLocalDependences()

  Genie.define "release", "test", ( version ) ->

    version ?= await Release.getType()

    Genie.run [
      "release:upgrade-local-dependencies"
      "release:version:#{version}"
      "release:publish"
      "release:push"
    ]
