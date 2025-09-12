{
  programs.zed-editor = {
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "alt-h" = "project_panel::ToggleHideGitIgnore";

          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "EmptyPane";
        bindings = {
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
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "terminal_panel::ToggleFocus";

          "ctrl-b" = "pane::ActivateNextItem";
        };
      }
      {
        context = "Editor && vim_mode == insert && !VimWaiting && !menu";
        bindings = {
          "ctrl-space" = "editor::ShowCompletions";
        };
      }
      {
        context = "Editor && vim_mode == visual && !VimWaiting && !menu";
        bindings = {
          "ctrl-space" = "editor::ShowCompletions";
          "ctrl-backspace" = "editor::SelectSmallerSyntaxNode";

          "u" = null; # Disabled to prevent accidental lowercase conversion
          "U" = null; # Disabled to prevent accidental uppercase conversion
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu && !AgentPanel";
        bindings = {
          "ctrl-space" = "editor::SelectLargerSyntaxNode";
          "ctrl-backspace" = "editor::SelectSmallerSyntaxNode";

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

          "space w" = "pane::CloseActiveItem";
          "space r n" = "editor::Rename";
          "space h" = "editor::ToggleInlayHints";
          "space x" = "editor::ToggleInlineDiagnostics";
          "space ," = "editor::ToggleCodeActions";
          "space o" = "outline::Toggle";
          "space y" = "editor::Copy";
          "space p" = "editor::Paste";
          "space g" = "editor::BlameHover";

          "space d b" = "editor::ToggleBreakpoint";
          "space d c" = "debugger::Continue";
          "space d t" = "debugger::Stop";
          "f10" = "debugger::StepOver";
          "f11" = "debugger::StepInto";
          "f12" = "debugger::StepOut";

          "g r" = "editor::FindAllReferences";

          "space F" = "editor::Format";

          "] h" = "editor::GoToHunk";
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
        context = "Terminal && !vim_mode";
        bindings = {
          "ctrl-/" = "workspace::ToggleBottomDock";
          "ctrl-t" = "workspace::ToggleBottomDock";
        };
      }
      {
        context = "ProjectPanel && not_editing";
        bindings = {
          "a" = "project_panel::NewFile";
          "r" = "project_panel::Rename";
          "l" = "project_panel::Open";
          "d" = "project_panel::Delete";
          "ctrl-l" = "workspace::ActivatePaneRight";
        };
      }
    ];
  };
}
