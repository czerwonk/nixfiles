{
  quality-review = ''
    Assess code against language-specific best practices and idioms. Identify quality issues and provide prioritized improvements.
  '';
  security-review = ''
    Identify security vulnerabilities following language-specific practices. Rank by severity (Critical/High/Medium/Low) with fixes.
  '';
  fix-build = ''
    Diagnose build failure: parse error messages, identify root causes, provide working code fixes with step-by-step resolution.
  '';
  version-update = ''
    Use $ARGUMENTS as VERSION, or ask me for it. Note the current version as OLD_VERSION first.
    Update this project's own version in every manifest present (Cargo.toml, package.json, pyproject.toml, etc.) and in version constants in source (e.g. `version` in main.go, `__version__`). Refresh lockfiles to match (e.g. `cargo metadata`, `npm version VERSION --no-git-tag-version`).
    Nix: update `version` in workspace.nix if it exists in the root, otherwise in package.nix files next to manifests. Leave dependency hashes alone.
    Helm: patch-bump the chart `version`, set `appVersion` to VERSION, and update the image tag in values.yaml if it pins OLD_VERSION.
    Then grep for remaining occurrences of OLD_VERSION (skip lockfiles, vendor/, node_modules/, target/, CHANGELOG). Update the clear matches; ask me about ambiguous ones. Never change dependency versions. Don't commit or tag.
    Finish with a short summary of changed files and old to new values.
  '';
  release-notes = ''
    Analyze all code changes since lastest tag. Build and output release notes in markdown code. Ensure the output is short and concise, focusing on the most important changes, exclude version bumps, unchanged features and do not repeat youself.
  '';
}
