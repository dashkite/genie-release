import { sh } from "./helpers"

export default ( Genie ) ->

  Genie.define "release:version", (version) ->
    [ version, tag ] = version.split "-"
    switch version
      when "alpha", "beta"
        sh "npm version prerelease --preid #{ version }"
      when "major", "minor", "patch"
        unless tag?
          sh "npm version #{ version }"
        else
          sh "npm version pre#{ version } --preid #{ tag }"
      when "development"
        # no-op: we leave that to other presets        
      else
        throw new Error "genie-release: unknown version: #{ version }"

  Genie.define "release:publish", -> sh "npm publish --access public"

  Genie.define "release:push", -> sh "git push --follow-tags"

  Genie.define "release", "test", ( version = "development" ) ->
    Genie.run [
      "release:version:#{version}"
      "release:publish"
      "release:push"
    ]
