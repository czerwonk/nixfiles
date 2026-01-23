{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      gphoto2
    ];
  };
}
