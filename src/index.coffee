import { $ } from "dax-sh"
import { Release, Dependencies, Git, Pkg, success, sleep } from "./helpers"

# $.quiet = true

export default ( Genie ) ->

  # TODO we need the await keyword below because
  # genie expects a promise, not a thenable, but dax-sh
  # returns thenables
  Genie.define "release:version", ( version ) ->
    [ version, tag ] = version.split "-"
    switch version
      when "alpha", "beta"
        await $"npm version prerelease --preid #{ version }"
      when "major", "minor", "patch"
        unless tag?
          await $"npm version #{ version }"
        else
          await $"npm version pre#{ version } --preid #{ tag }"
      else
        throw new Error "genie-release: 
          unknown version type: #{ version }"

  Genie.define "release:publish", -> 
    await $"npm publish --access public"

  Genie.define "release:push", ->

    await $"git push --follow-tags"

    # confirm that NPM has the right version

    # we do this after pushing the tags instead of after the publish
    # because NPM has promised us (by not failing on the publish)
    # that the publish was successful, so we're simply confirming
    # in case there are dependent tasks that need the module to be
    # availble in NPM...

    local = await Pkg.localVersion()
    count = 1
    # give everything an extra 10 seconds to be safe
    pause = 15 * 1000
    # NPM caches reponses for 5 min
    # we give it an extra 10 seconds to be sure
    interval = ( 5 * 60 * 1000 ) + pause
    # 3 retries = 15 min
    retries = 3
    console.error "genie-release: verifying publish..."
    # we must appease the angry NPM god: initially give it
    # some time (10 seconds) to (hopefully) avoid caching a
    # 404, because it caches it for 5 min :o
    await sleep pause
    loop
      remote = await Pkg.version "."
      break if (( local == remote ) || ( count++ > retries ))
      await sleep interval
    if count > retries
      throw new Error "genie-release:
        unable to confirm NPM publish was successful" 
    
  Genie.define "release:update-published-dependencies", ->
    Dependencies.updatePublished()

  Genie.define "release:update-local-dependencies", ->
    Dependencies.updateLocal()


  # TODO add dependency on test task
  #      in theory, genie supports optional tasks
  #      but we got an undefined task ('Starting undefined')
  #      and an error:
  #      Cannot read properties of undefined (reading 'initialize')

  # TODO add check to make sure the files property of the package.json
  #      file is populated. other integrity checks?

  Genie.define "release:update-dependencies", [
    "release:update-published-dependencies"
    "release:update-local-dependencies"
  ]

  Genie.define "release", ( version ) ->

    if await Git.isClean()

      await Genie.run "release:update-dependencies"

      if await Pkg.hasChanges()

        version ?= await Release.getType()

        await Genie.run [
          "release:version:#{version}"
          "release:publish"
          "release:push"
        ]

        if Release.stable()
          # set to something unlikely to collide with 
          # existing shell conventions so that Tempo
          # can possibly make use of this later
          process.exitCode = 255
          throw new Error "genie-release:
            package unstable: new version published"

    else

      throw new Error "genie-release:
        unable to release because 
        there are uncommitted changes"

