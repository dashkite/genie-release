# Technical Notes

### Genie Preset Technology and the Release Lifecycle

This module is designed using the Genie preset technology, which allows it to be automatically registered and seamlessly integrated into the task runner without manual configuration. As part of this architecture, `release` represents one of the major lifecycle events for a library. By providing this as a standardized preset, we ensure that the critical step of transitioning a library from a development state to a published state is uniform across projects, encapsulating all the necessary lifecycle hooks under a unified set of commands.

### Publish Verification

The `release:push` task includes a robust verification step after pushing to git. It polls the NPM registry to ensure that the remote version matches the newly published local version. This is required because NPM can sometimes successfully accept a publish request but delay exposing the new version on the registry. The verification helps ensure dependent tasks don't fail by waiting up to 15 minutes, with periodic retries, for the registry cache to clear.

### Dependency Management

The release preset explicitly separates the updating of published dependencies from local dependencies (`release:update-published-dependencies` and `release:update-local-dependencies`). This ensures that the module correctly resolves and relies on the latest compatible versions of its dependencies before a release is cut.

### Unstable Release Failure

When a stable release is created and successfully published, the `release` task forces an exit code of `255` and throws an error stating `package unstable: new version published`. This prevents downstream processes (like Tempo) from mistakenly continuing to execute against the previous configuration.
