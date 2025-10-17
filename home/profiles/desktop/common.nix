{
  pkgs,
  lib,
  config,
  username,
  ...
}:

{
  imports = [
    ../../programs/ghostty
    ../../programs/zed
    ./librewolf.nix
  ];

  programs.zsh.shellAliases = {
    ycode = "${lib.getExe pkgs.yubikey-manager} oath accounts code | ${lib.getExe config.programs.fzf.package} --tmux";
    bww = "BITWARDENCLI_APPDATA_DIR='/home/${username}/.config/Bitwarden CLI Work' ${lib.getExe pkgs.bitwarden-cli} $@";
  };

  programs.tmux.mouse = true;

  services.gpg-agent.enable = true;

  home = {
    packages = with pkgs; [
      bitwarden-cli
      zbar
    ];
  };

  programs.zsh = {
    shellAliases = {
      docker = "${lib.getExe pkgs.podman}";
    };
  };
}
