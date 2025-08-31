{
  programs.zed-editor = {
    enable = true;
    extensions = [ "kanagawa-themes" ];
    userSettings = {
      theme = "Kanagawa Wave";
      vim_mode = true;
      relative_line_numbers = true;
      ui_font_family = "JetBrains Mono";
      ui_font_size = 16;
      buffer_font_family = "JetBrains Mono";
      buffer_font_size = 16;
      lsp_document_colors = "inline";
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
        toolbar = {
          title = true;
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
        git_diff = true;
        search_results = true;
        selected_symbol = true;
        diagnostics = "all";
      };
      git = {
        git_gutter = "tracked_files";
        inline_blame = {
          enabled = false;
        };
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
        context = "Editor && vim_mode == normal && !VimWaiting && !menu";
        bindings = {
          "ctrl-space" = "editor::SelectLargerSyntaxNode";
          "backspace" = "editor::SelectSmallerSyntaxNode";

          "space f f" = "file_finder::Toggle";
          "space f g" = "pane::DeploySearch";
          "space f k" = "zed::OpenKeymap";

          "ctrl-b" = "pane::ActivateNextItem";

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

          "ctrl-t" = "terminal_panel::ToggleFocus";

          "space F" = "editor::Format";

          "ctrl-h" = "project_panel::ToggleFocus";
          "ctrl-l" = "pane::ActivateNextItem";

          "space w" = "pane::CloseActiveItem";

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
        context = "ProjectPanel && !vim_mode";
        bindings = {
          "ctrl-n" = "project_panel::ToggleFocus";
        };
      }
    ];
  };
}
