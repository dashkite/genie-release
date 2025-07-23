import assert from "@dashkite/assert"
import {test, success} from "@dashkite/amen"
import print from "@dashkite/amen-console"

import { $ } from "dax-sh"
import { Git, Pkg } from "../src/helpers"


do ->

  print await test "Genie Release", [

    # Ensure we fully understand the semantics of $
    test "dax", ->

      # awaiting on a successful command just returns a result
      result = await $"exit 0"
      assert result.code == 0

      # unsuccessful commands return a thenable but do not throw
      assert ( $"exit 1" ).then?

      # the returned thenable is NOT a promise, per se
      assert !(( $"exit 1") instanceof Promise )

      # if we await on the thenable, it will throw
      # this is the pattern we'd typically follow
      assert.rejects -> $"exit 1"

      # method chaining works on the thenable
      assert.rejects ->
        $"exit 1"
          .text()

    test "git helpers", [

      test "get last commit", ->
        local = await Git.getLastCommit "."
        assert /Z$/.test local

    ]

    test "package helpers", [
      
      test "get specifier (version)", ->
        assert /\d$/.test await Pkg.specifier "dax-sh"

      test "get last-modified", ->
        assert /Z$/.test await Pkg.modified "dax-sh"

    ]

  ]

  process.exit if success then 0 else 1
