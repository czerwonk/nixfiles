{ pkgs, lib, ... }:

let
  codex-bwrapped = pkgs.writeShellScriptBin "codex" ''
    exec ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$HOME/.codex" "$HOME/.codex" \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe pkgs.codex} "$@"
  '';

in
{
  home = {
    packages = [
      codex-bwrapped
    ];
  };
}
