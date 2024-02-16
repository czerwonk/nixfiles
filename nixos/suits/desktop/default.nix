{ pkgs, lib, username, ... }:

{
  imports = [
    ./core.nix
    ./pam.nix
    ./gnome.nix
    ./impermanence.nix
  ];

  security.chromiumSuidSandbox.enable = true;

  programs.firejail.wrappedBinaries = {
    brave = {
      executable = "${pkgs.lib.getBin pkgs.brave}/bin/brave";
      desktop = "${pkgs.brave}/share/applications/brave-browser.desktop";
      profile = pkgs.writeText "brave.local" ''
        noblacklist ''${DOWNLOADS}
        whitelist ''${DOWNLOADS}
        include brave.profile
      '';
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
      foliate
      gimp
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

  services.teamviewer.enable = true;

  programs.wireshark.enable = true;

  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  programs.nix-ld.enable = true;

  services.flatpak.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.pcscd.enable = true;

  virtualisation.virtualbox.host = {
    enable = true;
  };

  my.services.openssh-server.enable = true;
  networking.firewall.extraInputRules = lib.mkAfter ''
    ip6 saddr 2001:678:1e0::/48 tcp dport 2222 accept
  '';
}
