{ lib, config, ... }:

{
  programs.oh-my-posh = {
    enable = lib.mkDefault true;
    enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext (builtins.readFile ./config.json)
    );
  };
}
