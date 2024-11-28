{ pkgs, hostname, username, ... }:

{
  nixpkgs.config.allowUnfree = true;

  services.nix-daemon.enable = true;
  programs.nix-index.enable = true;

  nix = {
    package = pkgs.lix;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  time.timeZone = "Europe/Berlin";

  networking.hostName = hostname;
  networking.computerName = hostname;

  users.users."${username}" = {
    home = "/Users/${username}";
    description = username;
  };

  system = {
    activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToControl = true;

    defaults = {
      menuExtraClock.Show24Hour = true;
      menuExtraClock.ShowSeconds = true;

      smb.NetBIOSName = hostname;

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
