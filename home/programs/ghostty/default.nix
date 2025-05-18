{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    enableZshIntegration = true;
    settings = {
      font-family = "JetBrains Mono";
      font-size = 12;
      confirm-close-surface = false;
      window-decoration = false;
      gtk-titlebar = false;

      foreground = "E1D9D1";
      background = "1F1F28";
      palette = [
        "1=C34043"
        "2=76946A"
        "3=E6C384"
        "4=7FB4CA"
        "11=FF9E3B"
        "31=A3D4D5"
        "76=98BB6C"
        "234=1F1F28"
      ];

      keybind = [
        "alt+w=close_surface"
        "alt+shift+l=new_split:right"
        "alt+shift+k=new_split:up"
        "alt+shift+j=new_split:down"
        "alt+shift+h=new_split:left"
        "alt+l=goto_split:right"
        "alt+k=goto_split:top"
        "alt+j=goto_split:bottom"
        "alt+h=goto_split:left"
      ];
    };
  };

  home = {
    packages = with pkgs; [
      jetbrains-mono
    ];
  };
}
