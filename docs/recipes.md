# Recipes

This document provides task-based scenarios for using the `genie-release` preset.

## Releasing a package

To release a package, invoke the primary `release` task. This task orchestrates updating dependencies, bumping the version, publishing, and pushing tags. It ensures the environment is clean before making any modifications.

```bash
npx genie release major
```

## Cleaning the build environment

If you need to ensure a clean build environment prior to a release or standard development, you can use the `clean` task. This clears out previous build artifacts.

```bash
npx genie clean
```

## Bumping a prerelease version

To create an alpha or beta prerelease, you can use the `release:version` task directly if you are manually stepping through the release process or running a custom script that manages the release differently.

```bash
npx genie release:version alpha
```

## Manually verifying publish status

Sometimes you may want to publish and verify the push manually. You can trigger the publish verification step explicitly.

```bash
npx genie release:push
```
