# Reference

This document provides a reference for the specific commands this preset adds to the `genie` task runner. 

## release

The primary lifecycle command that orchestrates the entire release process.

*   Verifies that the git working directory is clean.
*   Updates local and published dependencies.
*   If there are changes, bumps the package version.
*   Publishes the package to NPM.
*   Pushes the commit and tags to the git remote.
*   Verifies the package was successfully published to NPM.

## release:version

Bumps the package version. It accepts a version argument which can be `major`, `minor`, `patch`, `alpha`, or `beta`. 

## release:publish

Publishes the package to the NPM registry with public access.

## release:push

Pushes git commits and tags to the remote repository and confirms the publish to NPM was successful by polling the registry.

## release:update-dependencies

A composite task that runs `release:update-published-dependencies` and `release:update-local-dependencies`.

## release:update-published-dependencies

Updates all published dependencies to their latest compatible versions.

## release:update-local-dependencies

Updates all local dependencies.

## clean

Removes the `build` and `.masonry` directories, ensuring a pristine state for the project.
