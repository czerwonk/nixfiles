{ pkgs, lib, config, ... }:

with lib;

let
  cfg = config.programs.zsh;

in {
  options = {
    programs.zsh.theme.enable = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.theme.enable {
    programs.zsh = {
      initExtraFirst = ''
        export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true
        export ZSH_THEME="powerlevel10k/powerlevel10k"
        source ~/.p10k.zsh
      '';
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
      ];
    };

    home.file.".p10k.zsh".source = ./p10k.zsh;
  };
}
