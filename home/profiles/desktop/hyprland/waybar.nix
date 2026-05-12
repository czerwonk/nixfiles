{
  programs.waybar.settings.mainBar = {
    modules-left = [ "hyprland/workspaces" ];
    "hyprland/workspaces" = {
      format = "{name}: {icon}";
      format-icons = {
        "default" = "";
        "1" = "";
        "2" = "";
        "3" = "";
        "4" = "✉";
        "5" = "";
        "10" = "";
      };
    };
  };
}
