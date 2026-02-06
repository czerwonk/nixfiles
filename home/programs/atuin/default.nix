{ lib, config, ... }:

{
  programs.atuin = {
    enable = lib.mkDefault false;
    enableZshIntegration = lib.mkDefault config.programs.zsh.enable;
    enableBashIntegration = lib.mkDefault config.programs.bash.enable;
    flags = [ "--disable-up-arrow" ];
    forceOverwriteSettings = true;
    settings = {
      history_filter = [
        "^git commit"
        "^git c "
        "^export "
        "Bearer "
        "-----BEGIN"
        "^[A-Za-z_]*(PASSWORD|SECRET|TOKEN|KEY|API|AUTH|CREDENTIAL)[A-Za-z_]*="
        "<<EOF"
      ];
      inline_height = 20;
      keymap_mode = "vim-insert";
      secrets_filter = true;
      show_help = false;
      show_preview = true;
      show_tabs = false;
      store_failed = false;
      style = "compact";
      sync_address = "";
      theme.name = "kanagawa";
      ui.columns = [
        "time"
        "duration"
        "command"
        {
          type = "directory";
          width = 20;
        }
      ];
      update_check = false;
    };
    themes.kanagawa = {
      theme = {
        name = "Kanagawa";
      };
      colors = {
        Base = "#DCD7BA"; # fujiWhite - default foreground
        Title = "#7E9CD8"; # crystalBlue - titles
        Guidance = "#727169"; # fujiGray - help text
        Important = "#E6C384"; # carpYellow - attention
        Annotation = "#C8C093"; # oldWhite - supporting text
        AlertInfo = "#7FB4CA"; # springBlue - info
        AlertWarn = "#FF9E3B"; # roninYellow - warning
        AlertError = "#658594"; # dragonBlue - error
      };
    };
  };
}
