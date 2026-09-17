{ lib, pkgs, ... }:

{
  xdg.configFile = {
    "cosmic/com.system76.CosmicAppList/v1/favorites" = {
      enable = true;
      force = true;
      text = ''
        [
            "com.system76.CosmicFiles",
            "com.system76.CosmicEdit",
            "com.system76.CosmicStore",
            "com.system76.CosmicSettings",
        ]
      '';
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
    "cosmic/com.system76.CosmicPanel/v1/entries" = {
      enable = true;
      force = true;
      text = ''
        [
            "Panel",
        ]
      '';
    };
    "cosmic/com.system76.CosmicPanel.Panel/v1/size" = {
      enable = true;
      force = true;
      text = "XS";
    };
    "cosmic/com.system76.CosmicPanel.Panel/v1/plugins_center" = {
      enable = true;
      force = true;
      text = ''
        Some([
            "com.system76.CosmicAppletTime",
        ])
      '';
    };
    "cosmic/com.system76.CosmicPanel.Panel/v1/plugins_wings" = {
      enable = true;
      force = true;
      text = ''
        Some(([
            "com.system76.CosmicPanelWorkspacesButton",
            "com.system76.CosmicPanelAppButton",
        ], [
            "com.system76.CosmicAppletInputSources",
            "com.system76.CosmicAppletStatusArea",
            "com.system76.CosmicAppletTiling",
            "com.system76.CosmicAppletAudio",
            "com.system76.CosmicAppletNetwork",
            "com.system76.CosmicAppletBattery",
            "com.system76.CosmicAppletNotifications",
            "com.system76.CosmicAppletBluetooth",
            "com.system76.CosmicAppletPower",
        ]))
      '';
    };
    "cosmic/com.system76.CosmicSettings.Shortcuts/v1/system_actions" = {
      enable = true;
      force = true;
      text = ''
        {
            Terminal: "${lib.getExe pkgs.ghostty} --gtk-single-instance=true",
        }
      '';
    };
    "cosmic/com.system76.CosmicTheme.Mode/v1/is_dark" = {
      enable = true;
      force = true;
      text = "true";
    };
    "cosmic/com.system76.CosmicTheme.Dark/v1/active_hint" = {
      enable = true;
      force = true;
      text = "3";
    };
    "cosmic/com.system76.CosmicTheme.Dark/v1/gaps" = {
      enable = true;
      force = true;
      text = "(0, 8)";
    };
    "cosmic/com.system76.CosmicTheme.Dark/v1/corner_radii" = {
      enable = true;
      force = true;
      text = ''
        (
            radius_0: (0.0, 0.0, 0.0, 0.0),
            radius_xs: (4.0, 4.0, 4.0, 4.0),
            radius_s: (8.0, 8.0, 8.0, 8.0),
            radius_m: (16.0, 16.0, 16.0, 16.0),
            radius_l: (32.0, 32.0, 32.0, 32.0),
            radius_xl: (160.0, 160.0, 160.0, 160.0),
        )
      '';
    };
    "cosmic/com.system76.CosmicTheme.Light/v1/active_hint" = {
      enable = true;
      force = true;
      text = "3";
    };
    "cosmic/com.system76.CosmicTheme.Light/v1/gaps" = {
      enable = true;
      force = true;
      text = "(0, 3)";
    };
    "cosmic/com.system76.CosmicTheme.Light/v1/corner_radii" = {
      enable = true;
      force = true;
      text = ''
        (
            radius_0: (0.0, 0.0, 0.0, 0.0),
            radius_xs: (2.0, 2.0, 2.0, 2.0),
            radius_s: (8.0, 8.0, 8.0, 8.0),
            radius_m: (8.0, 8.0, 8.0, 8.0),
            radius_l: (8.0, 8.0, 8.0, 8.0),
            radius_xl: (8.0, 8.0, 8.0, 8.0),
        )
      '';
    };
    "cosmic/com.system76.CosmicTk/v1/header_size" = {
      enable = true;
      force = true;
      text = "Compact";
    };
    "cosmic/com.system76.CosmicTk/v1/interface_density" = {
      enable = true;
      force = true;
      text = "Compact";
    };
  };
}
