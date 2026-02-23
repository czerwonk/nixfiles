{
  pkgs,
  lib,
  username,
  ...
}:

{
  imports = [
    ./core.nix
    ./firejail-icons.nix
    ./impermanence.nix
    ./pam.nix
    ./sound.nix
    ./thumbnails.nix
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
    fractal = {
      executable = "${pkgs.lib.getExe pkgs.fractal}";
      desktop = "${pkgs.fractal}/share/applications/org.gnome.Fractal.desktop";
      profile = "${pkgs.firejail}/etc/firejail/fractal.profile";
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
      bitwarden-desktop
      bruno
      calibre
      cameractrls-gtk4
      dbeaver-bin
      filezilla
      google-chrome
      libreoffice
      mattermost-desktop
      nextcloud-client
      remmina
      termius
      vlc
      wireshark
      xsel
      yubioath-flutter
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

  services.teamviewer.enable = true;
  systemd.services.teamviewerd.wantedBy = lib.mkForce [ ];
}
