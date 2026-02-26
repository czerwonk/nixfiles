{
  imports = [
    ./theme.nix
    ./languages.nix
    ./lsp.nix
  ];

  programs.zed-editor = {
    userSettings = {
      auto_update = false;
      vim_mode = true;
      vim = {
        use_system_clipboard = "never";
        use_smartcase_find = true;
        toggle_relative_line_numbers = true;
      };
      cursor_blink = false;
      hide_mouse = "on_typing_and_movement";
      tab_size = 2;
      preferred_line_length = 120;
      show_whitespaces = "all";
      relative_line_numbers = "enabled";
      current_line_highlight = "gutter";
      format_on_save = "on";
      remove_trailing_whitespace_on_save = true;
      scroll_beyond_last_line = "off";
      vertical_scroll_margin = 8;
      edit_predictions = {
        provider = "copilot";
      };
      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
      };
      title_bar = {
        show_branch_icon = true;
      };
      toolbar = {
        breadcrumbs = false;
        code_actions = false;
        quick_actions = false;
        selections_menu = false;
      };
      tab_bar = {
        show_nav_history_buttons = false;
      };
      tabs = {
        git_status = true;
        file_icons = true;
        show_diagnostics = "all";
      };
      project_panel = {
        hide_gitignore = true;
      };
      scrollbar = {
        show = "never";
      };
      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = false;
        };
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
    };
  };
}
