{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [ "kanagawa-themes" ];
    userSettings = {
      theme = "Kanagawa Wave";
      vim_mode = true;
      relative_line_numbers = true;
      ui_font_family = "JetBrains Mono";
      ui_font_size = 14;
      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 14;
      cursor_blink = false;
      hour_format = "hour24";
      auto_update = false;
      show_whitespaces = "all";
      telemetry = {
        metrics = false;
        diagnostics = false;
      };
      terminal = {
        alternate_scroll = "off";
        blinking = "terminal_controlled";
        copy_on_select = false;
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
      inlay_hints = {
        enabled = true;
        show_type_hints = true;
        show_parameter_hints = true;
        show_other_hints = true;
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
      format_on_save = "on";
      features = {
        edit_prediction_provider = "copilot";
      };
      languages = {
        rust = {
          formatter = "rustfmt";
        };
        go = {
          formatter = "gofumpt";
        };
        lua = {
          formatter = "stylua";
        };
        TypeScript = {
          language_servers = [ "typescript-language-servertsserver" ];
        };
      };
      lsp = {
        rust-analyzer = {
          binary = {
            path_lookup = true;
          };
        };
        gopls = {
          binary = {
            path_lookup = true;
          };
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
    };
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "ctrl-h" = "project_panel::ToggleFocus";
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

          "g r" = "editor::FindAllReferences";

          "space rn" = "editor::Rename";
          "space h" = "editor::ToggleInlayHints";
          "space ," = "editor::ToggleCodeActions";
          "space o" = "outline::Toggle";

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
}
