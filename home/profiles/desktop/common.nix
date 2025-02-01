{ pkgs, lib, config, ... }:

{
  imports = [
    ../../programs/ghostty
  ];

  programs.zsh.shellAliases = {
    ycode = "${lib.getExe pkgs.yubikey-manager} oath accounts code | ${lib.getExe config.programs.fzf.package} --tmux";
  };

  programs.tmux.mouse = true;

  services.gpg-agent.enable = true;

  services.cliphist = {
    enable = true;
    extraOptions = [
      "-max-items"
      "10"
    ];
  };
}
