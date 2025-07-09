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
    Ask me for a version number referred as VERSION. Update the version in all cargo.toml files to VERSION in this workspace. If a package.nix exists in the same directory, also update the version in the nix file and set the cargoHash to empty string.
  '';
}
