{ pkgs, lib, ... }:

let
  claude-code-bwrapped = pkgs.writeShellScriptBin "claude" ''
    # Bind the whole repository, not only the current directory, so .git stays writable
    # when claude is started in a subdirectory.
    workdir="$(${lib.getExe pkgs.git} rev-parse --show-toplevel 2>/dev/null || pwd)"

    # Tool caches/state (go, cargo, podman, ansible) must be writable, the rest of $HOME stays
    # read-only. bin directories are deliberately not bound to prevent planting executables.
    exec ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --bind /tmp /tmp \
                                  --bind "$HOME/.claude" "$HOME/.claude" \
                                  --bind "$HOME/.claude.json" "$HOME/.claude.json" \
                                  --bind-try "$HOME/.cache" "$HOME/.cache" \
                                  --bind-try "$HOME/go/pkg" "$HOME/go/pkg" \
                                  --bind-try "$HOME/.cargo/registry" "$HOME/.cargo/registry" \
                                  --bind-try "$HOME/.cargo/git" "$HOME/.cargo/git" \
                                  --bind-try "$HOME/.local/share/containers" "$HOME/.local/share/containers" \
                                  --bind-try "$HOME/.ansible" "$HOME/.ansible" \
                                  --bind "$workdir" "$workdir" \
                                  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
                                  --proc /proc \
                                  --dev /dev \
      ${lib.getExe pkgs.claude-code} "$@"
  '';

  # Formats only the edited file (cheap enough to run after every edit); linters stay in the
  # language guides' checklists. Formatters missing from PATH are skipped silently.
  format-hook = pkgs.writeShellScript "claude-format-hook" ''
    file="$(${lib.getExe pkgs.jq} -r '.tool_input.file_path // empty')"
    [ -n "$file" ] && [ -f "$file" ] || exit 0

    has() { command -v "$1" >/dev/null 2>&1; }

    case "$file" in
      *.go) has gofmt && gofmt -w "$file" ;;
      *.rs)
        manifest_dir="$(dirname "$file")"
        while [ "$manifest_dir" != "/" ] && [ ! -f "$manifest_dir/Cargo.toml" ]; do
          manifest_dir="$(dirname "$manifest_dir")"
        done
        [ -f "$manifest_dir/Cargo.toml" ] && has cargo && (cd "$manifest_dir" && cargo fmt -q)
        ;;
      *.js|*.ts|*.jsx|*.tsx|*.html|*.css|*.json) has prettierd && prettierd "$file" < "$file" > "$file.fmt" && mv "$file.fmt" "$file" ;;
      *.nix) has nixfmt && nixfmt "$file" ;;
    esac
    rm -f "$file.fmt"
    exit 0
  '';

  skills = import ./command-prompts.nix;
in
{
  imports = [
    (import ./rules {
      configDir = ".claude";
      mainConfigFile = "CLAUDE.md";
    })
  ];

  home = {
    packages = [
      claude-code-bwrapped
    ];
  };

  home.file = {
    ".claude/settings.json".text = builtins.toJSON {
      editorMode = "vim";
      tui = "fullscreen";
      permissions.ask = [
        "Bash(podman:*)"
        "Bash(docker:*)"
        "Bash(ssh:*)"
        "Bash(rsync:*)"
        "Bash(sftp:*)"
      ];
      hooks.PostToolUse = [
        {
          matcher = "Edit|MultiEdit|Write";
          hooks = [
            {
              type = "command";
              command = "${format-hook}";
            }
          ];
        }
      ];
    };
  }
  // lib.mapAttrs' (
    name: skill:
    lib.nameValuePair ".claude/skills/${name}/SKILL.md" {
      text = ''
        ---
        name: ${name}
        description: ${skill.description}
        disable-model-invocation: true
        ---
        ${skill.prompt}
      '';
    }
  ) skills;
}
