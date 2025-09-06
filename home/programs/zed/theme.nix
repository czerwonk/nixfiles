{
  programs.zed-editor = {
    userSettings = {
      theme = "Kanagawa Wave";
      icon_theme = "Material Icon Theme";
      ui_font_family = "JetBrains Mono";
      ui_font_size = 16;
      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 16;
    };
  };

  home.file.".config/zed/themes/Kanagawa-Custom.json".source = ./Kanagawa-Custom.json;
}
