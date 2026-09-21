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
  };
}
