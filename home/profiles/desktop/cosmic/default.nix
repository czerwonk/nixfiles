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

  xdg.mimeApps.defaultApplications = {
    # browser
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";

    # mail & calendar
    "x-scheme-handler/mailto" = "thunderbird.desktop";
    "message/rfc822" = "thunderbird.desktop";
    "x-scheme-handler/mid" = "thunderbird.desktop";
    "x-scheme-handler/webcal" = "thunderbird.desktop";
    "x-scheme-handler/webcals" = "thunderbird.desktop";
    "text/calendar" = "thunderbird.desktop";
    "application/x-extension-ics" = "thunderbird.desktop";

    # chat & app links
    "x-scheme-handler/msteams" = "teams-for-linux.desktop";
    "x-scheme-handler/bruno" = "bruno.desktop";

    # office documents
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
    "application/vnd.oasis.opendocument.text" = "writer.desktop";
    "application/pdf" = "com.system76.CosmicReader.desktop";

    # text
    "text/plain" = "com.system76.CosmicEdit.desktop";
    "text/x-lua" = "com.system76.CosmicEdit.desktop";
    "application/x-zerosize" = "com.system76.CosmicEdit.desktop";

    # images
    "image/jpeg" = "com.xnview.XnViewMP.desktop";
    "image/heif" = "com.xnview.XnViewMP.desktop";
    "image/x-adobe-dng" = "com.xnview.XnViewMP.desktop";
    "image/x-canon-cr3" = "com.xnview.XnViewMP.desktop";

    # ebooks
    "application/epub+zip" = "com.calibre_ebook.calibre.ebook-viewer.desktop";
    "application/x-mobipocket-ebook" = "com.calibre_ebook.calibre.ebook-viewer.desktop";

    # video
    "video/mp4" = "com.system76.CosmicPlayer.desktop";
    "video/x-matroska" = "com.system76.CosmicPlayer.desktop";
    "video/webm" = "com.system76.CosmicPlayer.desktop";
    "video/quicktime" = "com.system76.CosmicPlayer.desktop";
    "video/mpeg" = "com.system76.CosmicPlayer.desktop";
    "video/x-msvideo" = "com.system76.CosmicPlayer.desktop";
    "video/x-ms-wmv" = "com.system76.CosmicPlayer.desktop";
    "video/3gpp" = "com.system76.CosmicPlayer.desktop";
    "video/3gpp2" = "com.system76.CosmicPlayer.desktop";
    "video/ogg" = "com.system76.CosmicPlayer.desktop";
    "video/x-flv" = "com.system76.CosmicPlayer.desktop";
  };

  services.gpg-agent.pinentry.package = pkgs.pinentry-gnome3;
}
