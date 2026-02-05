{
  pkgs,
  lib,
  username,
  ...
}:

{
  imports = [
    ./librewolf.nix
    ./ycode.nix
  ];

  programs.ghostty.enable = true;
  programs.zed-editor.enable = true;

  programs.tmux.mouse = true;

  programs.zsh.shellAliases = {
    bww = "BITWARDENCLI_APPDATA_DIR='/home/${username}/.config/Bitwarden CLI Work' ${lib.getExe pkgs.bitwarden-cli} $@";
    docker = "${lib.getExe pkgs.podman}";
  };

  services.gpg-agent.enable = true;

  home = {
    packages = with pkgs; [
      bitwarden-cli
    ];
  };
}
