{
  xdg.configFile = {
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
    "cosmic/com.system76.CosmicComp/v1/autotile_behavior" = {
      enable = true;
      force = true;
      text = "PerWorkspace";
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
    "cosmic/com.system76.CosmicComp/v1/xkb_config" = {
      enable = true;
      force = true;
      text = ''
        (
            rules: "",
            model: "pc104",
            layout: "us",
            variant: "altgr-intl",
            options: Some("caps:escape"),
            repeat_delay: 600,
            repeat_rate: 25,
        )
      '';
    };
  };
}
