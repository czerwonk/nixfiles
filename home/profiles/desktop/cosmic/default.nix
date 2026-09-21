{ lib, pkgs, ... }:

{
  imports = [
    ../common.nix
  ];

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
    "cosmic/com.system76.CosmicTheme.Dark.Builder/v1/accent" = {
      enable = true;
      force = true;
      text = ''
        Some((
            red: 0.78431374,
            green: 0.7529412,
            blue: 0.5764706,
        ))
      '';
    };
    "cosmic/com.system76.CosmicTheme.Dark.Builder/v1/bg_color" = {
      enable = true;
      force = true;
      text = ''
        Some((
            red: 0.08627451,
            green: 0.08627451,
            blue: 0.11372549,
            alpha: 1.0,
        ))
      '';
    };
    "cosmic/com.system76.CosmicTheme.Dark.Builder/v1/primary_container_bg" = {
      enable = true;
      force = true;
      text = ''
        Some((
            red: 0.12156863,
            green: 0.12156863,
            blue: 0.15686275,
            alpha: 1.0,
        ))
      '';
    };
    "cosmic/com.system76.CosmicTheme.Dark.Builder/v1/neutral_tint" = {
      enable = true;
      force = true;
      text = ''
        Some((
            red: 0.5254902,
            green: 0.67058825,
            blue: 0.6431373,
        ))
      '';
    };
    "cosmic/com.system76.CosmicTheme.Dark.Builder/v1/text_tint" = {
      enable = true;
      force = true;
      text = ''
        Some((
            red: 0.8627451,
            green: 0.84313726,
            blue: 0.7294118,
        ))
      '';
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
    "cosmic/com.system76.CosmicSettings.Shortcuts/v1/custom" = {
      enable = true;
      force = true;
      text = ''
        {
            (modifiers: [Super, Shift], key: "s"): System(Screenshot),
        }
      '';
    };
  };

  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
}
