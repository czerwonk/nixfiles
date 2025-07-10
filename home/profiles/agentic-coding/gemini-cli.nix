{ pkgs, lib, ... }:

let
  gemini-cli-bwrapped = pkgs.writeShellScriptBin "gemini" ''
    ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$HOME/.gemini" "$HOME/.gemini" \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe pkgs.gemini-cli} $@
  '';

in
{
  imports = [
    (import ./rules {
      configDir = ".gemini";
      mainConfigFile = "GEMINI.md";
    })
  ];

  home = {
    packages = [
      gemini-cli-bwrapped
    ];
  };
}
