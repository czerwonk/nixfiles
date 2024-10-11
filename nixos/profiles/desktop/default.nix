{ pkgs, username, ... }:

{
  imports = [
    ./android.nix
    ./core.nix
    ./firejail-icons.nix
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
  security.unprivilegedUsernsClone = true;

  programs.firejail.wrappedBinaries = {
    chromium = {
      executable = "${pkgs.lib.getBin pkgs.chromium}/bin/chromium";
      desktop = "${pkgs.chromium}/share/applications/chromium-browser.desktop";
      profile = "${pkgs.firejail}/etc/firejail/chromium-browser.profile";
    };
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
    teams-for-linux = {
      executable = "${pkgs.lib.getBin pkgs.teams-for-linux}/bin/teams-for-linux";
      desktop = "${pkgs.teams-for-linux}/share/applications/teams-for-linux.desktop";
      profile = pkgs.writeText "teams-for-linux.local" ''
        ignore novideo
        include teams-for-linux.profile
      '';
    };
    thunderbird = {
      executable = "${pkgs.lib.getBin pkgs.thunderbird}/bin/thunderbird";
      desktop = "${pkgs.thunderbird}/share/applications/thunderbird.desktop";
      profile = "${pkgs.firejail}/etc/firejail/thunderbird.profile";
    };
  };

  users.users.${username} = {
    packages = with pkgs; [
      appimage-run
      ausweisapp
      bitwarden
      blueberry
      bruno
      calibre
      crowdsec
      distrobox
      foliate
      fractal
      libreoffice
      mattermost-desktop
      mysql-workbench
      nextcloud-client
      remmina
      sublime4
      termius
      veracrypt
      virt-viewer
      vlc
      wgnord
      wireshark
      xsel
    ];
    extraGroups = [ "wireshark" ];
  };

  programs.xwayland.enable = true;

  programs.nix-index.enable = true;
  programs.nix-ld.enable = true;
  programs.command-not-found.enable = false;

  programs.wireshark.enable = true;

  services.flatpak.enable = true;
  services.pcscd.enable = true;

  my.services.crowdsec = {
    enable = true;
    autoStart = false;
    enableMitigation = false;
  };
}
