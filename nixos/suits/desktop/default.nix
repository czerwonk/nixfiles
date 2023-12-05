{ pkgs, lib, config, username, ... }:

{
  imports = [
    ./gnome-core.nix
  ];

  boot.kernelModules = [
    "usbserial"
    "ccm" # required for personal hotspot
    "qrtr"
  ];

  users.users.${username} = {
    packages = with pkgs; [
      xsel
      brave
      thunderbird
      libreoffice
      termius
      vlc
      docker-compose
      wireshark
      calibre
      remmina
      teamviewer
      mattermost-desktop
      virt-viewer
      yubioath-flutter
      mysql-workbench
    ];
    extraGroups = [ "wireshark" ];
  };
  programs.wireshark.enable = true;
  programs._1password-gui.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.pcscd.enable = true;

  security.pam.services.login.fprintAuth = false;
  security.pam.services.su.fprintAuth = false;
  security.pam.services.sudo.fprintAuth = false;
  security.pam.u2f = {
    enable = true;
    control = "required";
  };
  security.pam.services.gdm-fingerprint = lib.mkIf (config.services.fprintd.enable) {
    text = ''
      auth       required                    pam_shells.so
      auth       requisite                   pam_nologin.so
      auth       requisite                   pam_faillock.so      preauth
      auth       required                    ${pkgs.fprintd}/lib/security/pam_fprintd.so
      auth       optional                    pam_permit.so
      auth       required                    pam_env.so
      auth       [success=ok default=1]      ${pkgs.gnome.gdm}/lib/security/pam_gdm.so
      auth       optional                    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so

      account    include                     login

      password   required                    pam_deny.so

      session    include                     login
      session    optional                    ${pkgs.gnome.gnome-keyring}/lib/security/pam_gnome_keyring.so auto_start
    '';
  };
}
