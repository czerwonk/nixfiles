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
  '';
  release-notes = ''
    Analyze git changes since latest tag. Format: emoji categories (🔒 Security, 🎨 UI, 🔧 Technical), bullet points with emojis, <10 words each, bold key terms, exclude version bumps and unchanged features, no duplicate descriptions
    across categories
  '';
  look-at-screenshot = ''
    Analyze the newst screenshot in the screenshot directory and eveluate it in the current context.
  '';
}
