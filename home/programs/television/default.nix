{ lib, ... }:

{
  programs.television = {
    enable = lib.mkDefault false;
    enableZshIntegration = true;

    settings = {
      shell_integration.keybindings = {
        smart_autocomplete = "ctrl-t";
        command_history = "ctrl-alt-r"; # moved out of atuin's way
      };

      ui = {
        theme = "kanagawa";

        input_bar.prompt = " ";
        status_bar = {
          separator_open = "";
          separator_close = "";
        };
      };
    };

    # kanagawa wave with the same palette overrides as neovim/ghostty
    # (crystalBlue -> springBlue, oniViolet -> roninYellow)
    themes.kanagawa = {
      background = "#1F1F28"; # sumiInk3
      border_fg = "#54546D"; # sumiInk6
      text_fg = "#DCD7BA"; # fujiWhite
      dimmed_text_fg = "#727169"; # fujiGray

      input_text_fg = "#E6C384"; # carpYellow
      result_count_fg = "#7AA89F"; # waveAqua2

      result_name_fg = "#DCD7BA"; # fujiWhite
      result_line_number_fg = "#658594"; # dragonBlue
      result_value_fg = "#C8C093"; # oldWhite
      selection_fg = "#98BB6C"; # springGreen
      selection_bg = "#2D4F67"; # waveBlue2
      match_fg = "#FF9E3B"; # roninYellow

      preview_title_fg = "#7FB4CA"; # springBlue

      channel_mode_fg = "#1F1F28";
      channel_mode_bg = "#7FB4CA"; # springBlue
      remote_control_mode_fg = "#1F1F28";
      remote_control_mode_bg = "#98BB6C"; # springGreen
      action_picker_mode_fg = "#1F1F28";
      action_picker_mode_bg = "#FF9E3B"; # roninYellow
    };
  };
}
