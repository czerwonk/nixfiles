{ username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
  };

  time.timeZone = "Europe/Berlin";

  system = {
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    stateVersion = 5;

    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;

    defaults = {
      menuExtraClock = {
        Show24Hour = true;
        ShowSeconds = false;
      };

      alf = {
        globalstate = 1;
      };

      trackpad = {
        Clicking = true;
        Dragging = true;
        TrackpadRightClick = true;
      };

      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        ApplePressAndHoldEnabled = false;
        AppleShowAllExtensions = true;
        AppleShowAllFiles = true;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSWindowShouldDragOnGesture = true;
        "com.apple.swipescrolldirection" = false;
      };

      dock = {
        autohide = false;
        magnification = false;
        show-recents = false;
      };

      finder = {
        ShowStatusBar = true;
        ShowPathbar = true;

        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;

        FXPreferredViewStyle = "Nlsv";
        _FXShowPosixPathInTitle = true;
        _FXSortFoldersFirst = true;
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      spaces.spans-displays = true;

      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 30;
      };

      SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
    };
  };

  users.users."${username}" = {
    home = "/Users/${username}";
  };

  security.pam.enableSudoTouchIdAuth = true;

  programs = {
    nix-index.enable = true;
  };

  services = {
    nix-daemon.enable = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    brews = [
      "wireshark"
    ];
    casks = [
      "adobe-digital-editions"
      "android-studio"
      "calibre"
      "firefox"
      "ghostty"
      "google-chrome"
      "kobo"
      "nextcloud"
      "postbox"
      "sublime-text"
    ];
    masApps = {
      Bitwarden = 1352778147;
      DaisyDisk = 411643860;
      "Termius - SSH & SFTP client" = 1176074088;
      "Mattermost Desktop" = 1614666244;
      Wireguard = 1451685025;
      Xcode = 497799835;
    };
  };

  nix-homebrew = {
    enable = true;
    autoMigrate = true;
    user = username;
  };

  environment.extraInit = let
    homeManagerSessionVars =
      "/etc/profiles/per-user/$USER/etc/profile.d/hm-session-vars.sh";
  in ''
    [[ -f ${homeManagerSessionVars} ]] && source ${homeManagerSessionVars}
  '';
}
