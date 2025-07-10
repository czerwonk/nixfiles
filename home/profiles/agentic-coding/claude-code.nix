{ pkgs, lib, ... }:

let
  claude-code-bwrapped = pkgs.writeShellScriptBin "claude" ''
    ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$HOME/.claude" "$HOME/.claude" \
                                  --bind "$HOME/.claude.json" "$HOME/.claude.json" \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe pkgs.claude-code} $@
  '';
  slash-prompts = import ./command-prompts.nix;
  report-update-instructions = ''
    If the file already exists analyze the existing report and update it (including new version information). Move resolved issues to a RESOLVED section and update ratings if necesary.
  '';

in
{
  imports = [
    (import ./rules {
      configDir = ".claude";
      mainConfigFile = "CLAUDE.md";
    })
  ];

  home = {
    packages = [
      claude-code-bwrapped
    ];
  };

  home.file.".claude/commands/code-review.md".text = ''
    ${slash-prompts.quality-review}
  '';
  home.file.".claude/commands/code-review-report.md".text = ''
    ${slash-prompts.quality-review}. Generate a markdown report summarizing the findings and recommendations and store it in REVIEW_REPORT.md. ${report-update-instructions}.
  '';
  home.file.".claude/commands/code-audit.md".text = ''
    ${slash-prompts.security-review}
  '';
  home.file.".claude/commands/code-audit-report.md".text = ''
    ${slash-prompts.security-review}. Generate a markdown report summarizing the findings and recommendations and store it in SECURITY_REPORT.md. ${report-update-instructions}.
  '';
  home.file.".claude/commands/fix-build.md".text = ''
    ${slash-prompts.fix-build}
  '';
  home.file.".claude/commands/version-update-rust.md".text = ''
    ${slash-prompts.version-update-rust}
  '';
}
