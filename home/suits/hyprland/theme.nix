{ pkgs, ... }:

let
  kanagawa-gtk-theme = pkgs.callPackage ./../../pkgs/kanagawa-gtk-theme {};

in {
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.capitaine-cursors;
    name = "capitaine-cursors";
    size = 24;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Kanagawa-B";
      package = kanagawa-gtk-theme;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };

  home.sessionVariables.GTK_THEME = "Kanagawa-B";
}
