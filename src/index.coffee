import { $ as sh } from "zx"

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
      else
        console.error "please specify the version, ex: `release:version:patch`."
        process.exit 1

  Genie.define "release:publish", -> sh "npm publish --access public"

  Genie.define "release:push", -> sh "git push --follow-tags"

  Genie.define "release", "test", (version) ->
    t.run [
      "release:version:#{version}"
      "release:publish"
      "release:push"
    ]
