{
  pkgs,
  lib,
  username,
  ...
}:

{
  imports = [
    ./firefox.nix
    ./ycode.nix
  ];

  programs.ghostty.enable = true;
  programs.zed-editor.enable = true;

  programs.tmux.mouse = true;

  programs.zsh.shellAliases = {
    bww = "BITWARDENCLI_APPDATA_DIR='/home/${username}/.config/Bitwarden CLI Work' ${lib.getExe pkgs.bitwarden-cli} $@";
  };

  services.gpg-agent.enable = true;

  home = {
    packages = with pkgs; [
      bitwarden-cli
    ];
  };
}
