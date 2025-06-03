{ pkgs, lib, ... }:

let
  claude-code-bwrapped = pkgs.writeShellScriptBin "claude" ''
    ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$HOME/.claude" "$HOME/.claude" \
                                  --bind "$HOME/.claude.json" "$HOME/.claude.json" \
                                  --bind "$(pwd)" "$(pwd)" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe pkgs.claude-code} $@
  '';

in
{
  home = {
    packages = [
      claude-code-bwrapped
    ];
  };

  home.file.".claude/CLAUDE.md".text = ''
    # Development Rules

    1. **Task Management**
       - Break into small, completable units
       - Track in `docs/todo.md`:
         - [ ] Current/upcoming tasks
         - [x] Completed tasks
         - Development decisions + rationale
         - Recurring issues + solutions
         - Technical debt
         - Code audit reminders

    2. **Git Discipline**
       - Commit after each code-modifying task
       - Format: `type: description` (feat/fix/docs/refactor/test/chore)

    3. **Scope Control**
       - Only implement explicit requests
       - Clarify ambiguities
       - Log additional ideas as separate tasks

    ## Workflow
    1. Pick task → Complete → Update todo.md → Commit
  '';
}
