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
  version-update-rust = ''
    Ask me for a version number referred as VERSION. Update the version in all cargo.toml files to VERSION in this workspace.
    If a package.nix exists in the same directory and it does not import a workspace.nix, also update the version in the nix file and set the cargoHash to empty string.
    If a workspace.nix exists in the project root, update the version in the workspace.nix file and set the cargoHash to empty string.
    If a helm chart exists update the version of the helm chart to the next minor version and set the appVersion to VERSION.
  '';
  release-notes = ''
    Analyze all code changes since lastest tag. Build and output release notes in markdown code. Ensure the output is short and concise, focusing on the most important changes, exclude version bumps, unchanged features and do not repeat youself.
  '';
  look-at-screenshot = ''
    Analyze the newst screenshot in the screenshot directory and eveluate it in the current context.
  '';
}
