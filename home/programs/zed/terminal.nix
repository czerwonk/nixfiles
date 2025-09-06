{
  programs.zed-editor = {
    userSettings = {
      terminal = {
        alternate_scroll = "off";
        blinking = "terminal_controlled";
        copy_on_select = true;
        dock = "bottom";
        env = {
          TERM = "xterm-256color";
        };
        font_family = "JetBrains Mono";
        font_size = 14;
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = {
          program = "zsh";
        };
        working_directory = "current_project_directory";
      };
    };
  };
}
