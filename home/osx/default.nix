{ pkgs, lib, username, ... }:

{
  imports = [
    ./../default.nix
    ./../profiles/desktop/common.nix
  ];
  
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      findutils
      gnused
      openssh
    ];
    file."Library/Keyboard Layouts/us-int-nodeadkeys.keylayout".text = builtins.readFile ./us-int-nodeadkeys.keylayout;
  };

  services.gpg-agent.enable = lib.mkForce false;
  home.file.".gnupg/gpg-agent.conf".text = ''
    default-cache-ttl 7200
    max-cache-ttl 86400
    enable-ssh-support
  '';
}
