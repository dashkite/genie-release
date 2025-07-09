import FS from "node:fs/promises"
import * as Genie from "@dashkite/genie"

Genie.define "clean", ->
  Promise.all [
    FS.rm "build", 
      recursive: true
      force: true
    FS.rm ".masonry", 
      recursive: true
      force: true
  ]
    