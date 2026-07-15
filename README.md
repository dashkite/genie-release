# Genie Release

*Genie Preset for managing module releases*

## Installation

This is a Genie preset and should be installed as a development dependency:

```bash
pnpm install -D @dashkite/genie-release
```

The preset is automatically registered by Genie. There is no need for manual initialization code.

## Overview

The `@dashkite/genie-release` module provides a comprehensive suite of Genie tasks to automate the process of versioning and publishing packages. It integrates with NPM and Git to bump versions, manage dependencies, publish packages to the NPM registry, and push tags to the remote repository. 

As a task preset, it aims to eliminate the repetitive boilerplate and manual steps traditionally involved in [Release Management](https://en.wikipedia.org/wiki/Release_management), reducing the risk of errors and ensuring a consistent release lifecycle across projects.

## Documentation

- [Reference](docs/reference.md)
- [Recipes](docs/recipes.md)
- [Technical Notes](docs/technical-notes.md)
- [Testing](docs/testing.md)
