{
  programs.zed-editor = {
    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          "alt-h" = "project_panel::ToggleHideGitIgnore";

          "ctrl-b" = "pane::ActivateNextItem";

          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Workspace && !AgentPanel";
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
          "space f k" = "zed::OpenKeymap";

          "space w" = "pane::CloseActiveItem";
          "space a" = "agent::ToggleFocus";
        };
      }
      {
        context = "Editor";
        bindings = {
          "ctrl-space" = "editor::SelectLargerSyntaxNode";
          "ctrl-backspace" = "editor::SelectSmallerSyntaxNode";

          "ctrl-h" = "workspace::ActivatePaneLeft";
          "ctrl-l" = "workspace::ActivatePaneRight";
          "ctrl-k" = "workspace::ActivatePaneUp";
          "ctrl-j" = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Editor && vim_mode == visual && !VimWaiting && !menu";
        bindings = {
          "u" = null; # Disabled to prevent accidental lowercase conversion
          "U" = null; # Disabled to prevent accidental uppercase conversion
        };
      }
      {
        context = "Editor && vim_mode == normal && !VimWaiting && !menu && !AgentPanel";
        bindings = {
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
          "ctrl-l" = "workspace::ActivatePaneRight";
        };
      }
    ];
  };
}
