{
  pkgs,
  lib,
  username,
  ...
}:

{
  imports = [
    ../../programs/ghostty
    ../../programs/zed
    ./librewolf.nix
    ./ycode.nix
  ];

  programs.zsh.shellAliases = {
    bww = "BITWARDENCLI_APPDATA_DIR='/home/${username}/.config/Bitwarden CLI Work' ${lib.getExe pkgs.bitwarden-cli} $@";
  };

  programs.tmux.mouse = true;

  services.gpg-agent.enable = true;

  home = {
    packages = with pkgs; [
      bitwarden-cli
    ];
  };

  programs.zsh = {
    shellAliases = {
      docker = "${lib.getExe pkgs.podman}";
    };
  };
}
