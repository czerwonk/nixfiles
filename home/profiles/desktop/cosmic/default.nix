{ pkgs, ... }:

{
  xdg.configFile = {
    "cosmic/com.system76.CosmicTheme.Mode/v1/is_dark" = {
      enable = true;
      force = true;
      text = "true";
    };
    "cosmic/com.system76.CosmicTheme.Dark/v1/gaps" = {
      enable = true;
      force = true;
      text = "(0, 0)";
    };
    "cosmic/com.system76.CosmicComp/v1/active_hint" = {
      enable = true;
      force = true;
      text = "false";
    };
    "cosmic/com.system76.CosmicComp/v1/autotile" = {
      enable = true;
      force = true;
      text = "true";
    };
    "cosmic/com.system76.CosmicComp/v1/workspaces" = {
      enable = true;
      force = true;
      text = ''
        (
          workspace_mode: OutputBound,
          workspace_layout: Horizontal,
        )
      '';
    };
  };

  services.gpg-agent.pinentry.package = pkgs.pinentry-gtk2;
}
