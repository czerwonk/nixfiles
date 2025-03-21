{ pkgs, lib, config, ... }:

with lib;

let
  nvim-bwrapped = pkgs.writeShellScriptBin "nvim-bwrapped" ''
    exec ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                       --ro-bind /nix /nix \
                                       --ro-bind /bin /bin \
                                       --ro-bind /etc /etc \
                                       --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                       --ro-bind "$HOME" "$HOME" \
                                       --tmpfs "$HOME/.ssh" \
                                       --ro-bind "$HOME/.ssh/known_hosts" "$HOME/.ssh/known_hosts" \
                                       --bind "$(pwd)" "$(pwd)" \
                                       --bind "$HOME/.local/share/nvim" "$HOME/.local/share/nvim" \
                                       --bind "$HOME/.local/state/nvim" "$HOME/.local/state/nvim" \
                                       --bind "$HOME/.cache" "$HOME/.cache" \
                                       --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                       --tmpfs /tmp \
                                       --proc /proc \
                                       --dev /dev \
      ${lib.getExe config.programs.neovim.finalPackage} "$@"
  '';

in {
  options = {
    programs.neovim.sandboxPackage = mkOption {
      type = types.package;
      readOnly = true;
    };
  };

  config = {
    programs.neovim.sandboxPackage = nvim-bwrapped;
  };
}
