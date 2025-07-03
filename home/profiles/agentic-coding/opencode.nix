{ pkgs, lib, ... }:

let
  configDir = ".config/opencode";
  opencode-bwrapped = pkgs.writeShellScriptBin "opencode" ''
    ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$HOME/.cache/opencode" "$HOME/.cache/opencode" \
                                  --bind "$HOME/.local/state/opencode" "$HOME/.local/state/opencode" \
                                  --bind "$HOME/.local/share/opencode" "$HOME/.local/share/opencode" \
                                  --bind "$HOME/${configDir}" "$HOME/${configDir}" \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe pkgs.opencode} $@
  '';
  slash-prompts = import ./command-prompts.nix;

in
{
  home = {
    packages = [
      opencode-bwrapped
    ];
  };

  home.file."${configDir}/AGENTS.md".text = builtins.readFile ./dev-rules.md;
  home.file."${configDir}/commands/code-review.md".text = ''
    ${slash-prompts.quality-review}
  '';
  home.file."${configDir}/commands/code-review-report.md".text = ''
    ${slash-prompts.quality-review}. Generate a markdown report summarizing the findings and recommendations and store it in REVIEW_REPORT.md
  '';
  home.file."${configDir}/commands/code-audit.md".text = ''
    ${slash-prompts.security-review}
  '';
  home.file."${configDir}/commands/code-audit-report.md".text = ''
    ${slash-prompts.security-review}. Generate a markdown report summarizing the findings and recommendations and store it in SECURITY_REPORT.md
  '';
  home.file."${configDir}/commands/fix-build.md".text = ''
    ${slash-prompts.fix-build}
  '';
}
