{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.my.programs.ghostty;

in {
  options = {
    my.programs.ghostty = {
      package = mkOption {
        type = types.nullOr types.package;
        default = pkgs.ghostty;
      };

      extraConfig = mkOption {
        type = types.str;
        default = "";
      };
    };
  };

  config = {
    home = {
      packages = with pkgs; [
        (mkIf (cfg.package != null) cfg.package)
        jetbrains-mono
      ];
      file.".config/ghostty/config".text = ''
        font-family = JetBrains Mono
        font-size = 12
        confirm-close-surface = false
        shell-integration = zsh
        window-decoration = false

        foreground = E1D9D1
        background = 1F1F28
        palette = 1=C34043
        palette = 2=76946A
        palette = 3=E6C384
        palette = 4=7FB4CA
        palette = 11=FF9E3B
        palette = 31=A3D4D5
        palette = 76=98BB6C
        palette = 234=1F1F28

        keybind = alt+w=close_surface
        keybind = alt+shift+l=new_split:right
        keybind = alt+shift+k=new_split:up
        keybind = alt+shift+j=new_split:down
        keybind = alt+shift+h=new_split:left
        keybind = alt+l=goto_split:right
        keybind = alt+k=goto_split:top
        keybind = alt+j=goto_split:bottom
        keybind = alt+h=goto_split:left

        ${cfg.extraConfig}
      '';
    };
  };
}
