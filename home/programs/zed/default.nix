{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "material-icon-theme"
      "html"
      "toml"
      "php"
      "dockerfile"
      "sql"
      "ruby"
      "make"
      "terraform"
      "lua"
      "csharp"
      "nix"
      "proto"
      "ansible"
      "marksman"
      "git-firefly"
    ];
    userSettings = {
      auto_update = false;
      theme = "Kanagawa Wave";
      icon_theme = "Material Icon Theme";
      ui_font_family = "JetBrains Mono";
      ui_font_size = 16;
      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 16;
      vim_mode = true;
      vim = {
        use_system_clipboard = "never";
        use_smartcase_find = true;
      };
      relative_line_numbers = true;
      cursor_blink = false;
      hide_mouse = "on_typing_and_movement";
      tab_size = 2;
      preferred_line_length = 120;
      show_whitespaces = "all";
      format_on_save = "on";
      remove_trailing_whitespace_on_save = true;
      diagnostics = {
        inline = {
          enabled = true;
        };
      };
      features = {
        edit_prediction_provider = "copilot";
      };
      indent_guides = {
        enabled = true;
      };
      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
      };
      current_line_highlight = "gutter";
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
      toolbar = {
        breadcrumbs = true;
        code_actions = true;
        quick_actions = false;
        selections_menu = false;
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
      project_panel = {
        hide_gitignore = true;
      };
      lsp = {
        rust-analyzer = {
        };
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true;
                nilness = true;
                shadow = true;
                unusedwrite = true;
                useany = true;
              };
              staticcheck = true;
              codelenses = {
                generate = true;
                gc_details = true;
                test = true;
                tidy = true;
                upgrade_dependency = true;
                vendor = true;
              };
            };
          };
        };
        typescript-language-server = {
          initialization_options = {
            preferences = {
              includeInlayParameterNameHints = "all";
              includeInlayParameterNameHintsWhenArgumentMatchesName = true;
              includeInlayFunctionParameterTypeHints = true;
              includeInlayVariableTypeHints = true;
              includeInlayVariableTypeHintsWhenTypeMatchesName = true;
              includeInlayPropertyDeclarationTypeHints = true;
              includeInlayFunctionLikeReturnTypeHints = true;
              includeInlayEnumMemberValueHints = true;
            };
          };
        };
      };
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
    };
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "alt-h" = "project_panel::ToggleHideGitIgnore";

          "space f f" = [
            "task::Spawn"
            {
              task_name = "File Finder";
              reveal_target = "center";
            }
          ];
          "space f g" = [
            "task::Spawn"
            {
              task_name = "Find in Files";
              reveal_target = "center";
            }
          ];
          "space f k" = "zed::OpenKeymap";

          "ctrl-b" = "pane::ActivateNextItem";
          "space w" = "pane::CloseActiveItem";

          "ctrl-t" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "vim_operator == a || vim_operator == i || vim_operator == cs";
        bindings = {
          "q" = "vim::MiniQuotes";
          "b" = "vim::MiniBrackets";
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          "ctrl-space" = "editor::SelectLargerSyntaxNode";
          "backspace" = "editor::SelectSmallerSyntaxNode";

          "ctrl-h" = "project_panel::ToggleFocus";
          "ctrl-j" = "terminal_panel::ToggleFocus";

          "g r" = "editor::FindAllReferences";

          "space rn" = "editor::Rename";
          "space h" = "editor::ToggleInlayHints";
          "space ," = "editor::ToggleCodeActions";
          "space o" = "outline::Toggle";
          "space y" = "editor::Copy";
          "space p" = "editor::Paste";

          "space d b" = "editor::ToggleBreakpoint";
          "space d c" = "debugger::Continue";
          "space d t" = "debugger::Stop";
          "f10" = "debugger::StepOver";
          "f11" = "debugger::StepInto";
          "f12" = "debugger::StepOut";

          "space F" = "editor::Format";

          "] h" = "editor::GoToHunk";
        };
      }
      {
        context = "Terminal && !vim_mode";
        bindings = {
          "ctrl-/" = "workspace::ToggleBottomDock";
          "ctrl-t" = "workspace::ToggleBottomDock";
        };
      }
      {
        context = "Dock";
        bindings = {
          "ctrl-w h" = "workspace::ActivatePaneLeft";
          "ctrl-w l" = "workspace::ActivatePaneRight";
          "ctrl-w k" = "workspace::ActivatePaneUp";
          "ctrl-w j" = "workspace::ActivatePaneDown";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "r" = "project_panel::Rename";
          "l" = "project_panel::Open";
          "ctrl-l" = "workspace::ActivatePaneRight";
        };
      }
    ];
    userTasks = [
      {
        label = "File Finder";
        command = "zeditor \"$(${lib.getExe pkgs.television} files)\"";
        hide = "always";
        allow_concurrent_runs = true;
        use_new_terminal = true;
      }
      {
        label = "Find in Files";
        command = "zeditor \"$(${lib.getExe pkgs.television} text)\"";
        hide = "always";
        allow_concurrent_runs = true;
        use_new_terminal = true;
      }
    ];
  };

  home.file.".config/zed/themes/Kanagawa-Custom.json".source = ./Kanagawa-Custom.json;
}
