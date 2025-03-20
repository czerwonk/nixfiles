{ pkgs, lib, config, ... }:

with lib;

let
  nvim-bwrapped = pkgs.writeShellScriptBin "nvim-bwrapped" ''
    export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"

    ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /etc/ /etc \
                                  --ro-bind /run /run \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$HOME/.local/share/nvim" "$HOME/.local/share/nvim" \
                                  --bind "$HOME/.local/state/nvim" "$HOME/.local/state/nvim" \
                                  --bind "$HOME/.cache" "$HOME/.cache" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe config.programs.neovim.finalPackage} $@
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
