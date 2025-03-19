{ pkgs, lib, username, ... }:

let
  nvim-bwrapped = pkgs.writeShellScriptBin "nvim-bwrapped" ''
    ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind "/etc/profiles/per-user/${username}" "/etc/profiles/per-user/${username}" \
                                  --ro-bind /run/current-system /run/current-system \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$HOME/.local/share/nvim" "$HOME/.local/share/nvim" \
                                  --bind "$HOME/.local/state/nvim" "$HOME/.local/state/nvim" \
                                  --proc /proc \
                                  --dev /dev \
      /etc/profiles/per-user/${username}/bin/nvim $@
  '';

in {
  home = {
    shellAliases = {
      nvim = "${nvim-bwrapped}/bin/nvim-bwrapped";
    };
  };

  #my.scripts.neovimExe = "${nvim-bwrapped}/bin/nvim-bwrapped";
}
