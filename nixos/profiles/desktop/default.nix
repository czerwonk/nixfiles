{ pkgs, lib, username, ... }:

{
  imports = [
    ./core.nix
    ./firejail-icons.nix
    ./gnome.nix
    ./impermanence.nix
    ./pam.nix
    ./sound.nix
  ];

  security.auditd.enable = false;

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  security.chromiumSuidSandbox.enable = true;

  programs.firejail.wrappedBinaries = {
    firefox = {
      executable = "${pkgs.lib.getBin pkgs.firefox}/bin/firefox";
      desktop = "${pkgs.firefox}/share/applications/firefox.desktop";
      profile = pkgs.writeText "firefox.local" ''
        noblacklist ''${DOWNLOADS}
        whitelist ''${DOWNLOADS}
        ignore nou2f
        include firefox.profile
      '';
      extraArgs = [
        # Enable system notifications
        "--dbus-user.talk=org.freedesktop.Notifications"
      ];
    };
    thunderbird = {
      executable = "${pkgs.lib.getBin pkgs.thunderbird}/bin/thunderbird";
      desktop = "${pkgs.thunderbird}/share/applications/thunderbird.desktop";
      profile = "${pkgs.firejail}/etc/firejail/thunderbird.profile";
    };
    element-desktop = {
      executable = "${pkgs.lib.getBin pkgs.element-desktop}/bin/element-desktop";
      desktop = "${pkgs.element-desktop}/share/applications/element-desktop.desktop";
      profile = "${pkgs.firejail}/etc/firejail/element-desktop.profile";
    };
    teams-for-linux = {
      executable = "${pkgs.lib.getBin pkgs.teams-for-linux}/bin/teams-for-linux";
      desktop = "${pkgs.teams-for-linux}/share/applications/teams-for-linux.desktop";
      profile = pkgs.writeText "teams-for-linux.local" ''
        ignore novideo
        include teams-for-linux.profile
      '';
    };
  };

  users.users.${username} = {
    packages = with pkgs; [
      appimage-run
      bitwarden
      blueberry
      calibre
      distrobox
      foliate
      fractal
      gimp
      chromium
      libation
      libreoffice
      mysql-workbench
      nextcloud-client
      nix-alien
      remmina
      sublime4
      termius
      veracrypt
      virt-viewer
      vlc
      wireshark
      xsel
    ];
    extraGroups = [ "wireshark" ];
  };

  services.xserver.displayManager.defaultSession = "hyprland";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.wlr = {
    enable = true;
    settings = {
      screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -ro";
      };
    };
  };

  programs.nix-index.enable = true;
  programs.nix-ld.enable = true;
  programs.command-not-found.enable = false;

  programs.wireshark.enable = true;

  services.teamviewer.enable = true;
  systemd.services.teamviewerd.wantedBy = lib.mkForce [];

  services.flatpak.enable = true;
  services.pcscd.enable = true;

  my.services.crowdsec = {
    enable = true;
    autoStart = false;
    enableMitigation = false;
  };
}
