{
  programs.zed-editor = {
    enable = true;
    extensions = [ "kanagawa-themes" ];
    userSettings = {
      theme = "Kanagawa Wave";
      vim_mode = true;
      ui_font_family = "JetBrains Mono";
      ui_font_size = 16;
      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 16;
      lsp_document_colors = "inline";
      cursor_blink = false;
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
    };
  };
}
