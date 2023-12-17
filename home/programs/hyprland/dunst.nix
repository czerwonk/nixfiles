{ pkgs, ... }:

{
  home.packages = [
    pkgs.libnotify
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        word_wrap = true;
        alignment = "center";
        width = "(300, 500)";
        height = 500;
        offset = "25x25";
        origin = "top-right";
        scale = 0;
        transparency = 10;
        frame_color = "#c8c093";
        font = "JetBrains Mono";
        sort = true;
        stack_duplicates = true;
        hide_duplicate_count = false;
        format = "<span font_weight='bold' font_size='small' fgcolor='#7FB4CA'>%a\\n%s %p</span>\\n\\n%b";
        line_height = 0;
        separator_height = 1;
        padding = 8;
        horizontal_padding = 10;
        text_icon_padding = 0;
        separator_color = "frame";
        corner_radius = 6;
        idle_threshold = 120;
        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
      };

      urgency_low = {
        background = "#727169";
        foreground = "#DCD7BA";
        timeout = 10;
      };

      urgency_normal = {
        background = "#2A2A37";
        foreground = "#DCD7BA";
        timeout = 10;
      };

      urgency_critical = {
        background = "#2D4F67";
        foreground = "#DCD7BA";
        timeout = 0;
      };
    };
  };
}
