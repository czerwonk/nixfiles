{
  time.timeZone = "Europe/Berlin";

  system = {
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToControl = true;

    defaults = {
      menuExtraClock.Show24Hour = true;
      menuExtraClock.ShowSeconds = true;

      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
      };

      NSGlobalDomain = {
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleShowAllFiles = true;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        "com.apple.swipescrolldirection" = false;
      };

      dock = {
        autohide = false;
        magnification = false;
      };

      finder = {
        ShowStatusBar = true;
        ShowPathbar = true;

        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirstOnDesktop = true;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };

  security.pam.enableSudoTouchIdAuth = true;

  programs.zsh.enable = true;

  environment.extraInit = let
    homeManagerSessionVars =
      "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh";
  in ''
    [[ -f ${homeManagerSessionVars} ]] && source ${homeManagerSessionVars}
  '';
}
