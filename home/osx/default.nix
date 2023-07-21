{ pkgs, username, ... }:

{
  imports = [
    ./../default.nix
    ./../suits/desktop
  ];
  
  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    packages = with pkgs; [
      qemu
      virt-viewer
      openssh
    ];
    file."Library/Keyboard Layouts/us-int-nodeadkeys.keylayout".text = builtins.readFile ./us-int-nodeadkeys.keylayout;
  };
}
