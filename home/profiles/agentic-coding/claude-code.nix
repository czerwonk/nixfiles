{ pkgs, lib, ... }:

let
  # Hidden inside the sandbox although $HOME is readable. Registry logins (~/.docker/config.json,
  # ~/.npmrc) and ~/.cargo/credentials.toml stay usable on purpose.
  hiddenHomeDirs = [
    # credentials
    ".kube"
    ".aws"
    ".config/gcloud"
    ".config/gh"
    ".config/sops"
    ".config/age"
    ".config/rclone"
    ".gnupg/private-keys-v1.d"
    ".password-store"
    ".local/share/keyrings"
    # personal data: browser sessions, mail, synced files, shell history
    ".mozilla"
    ".librewolf"
    ".config/google-chrome"
    ".config/chromium"
    ".config/BraveSoftware"
    ".thunderbird"
    "Nextcloud"
    ".config/Nextcloud"
    ".local/share/atuin"
    ".atuin"
  ];
  hiddenHomeFiles = [
    ".zsh_history"
    ".bash_history"
    ".netrc"
    ".git-credentials"
    ".pgpass"
    ".my.cnf"
  ];
  # Only these runtime sockets are reachable: the gpg/ssh agent for git push/signing and podman
  # (every call is reviewed). Everything else in $XDG_RUNTIME_DIR would allow running commands
  # outside the sandbox (systemd --user, tmux, nvim) or reading secrets (session bus, keyring).
  runtimeDirs = [
    "gnupg"
    "podman"
    "containers"
    "libpod"
  ];

  claude-code-bwrapped = pkgs.writeShellScriptBin "claude" ''
    # Bind the whole repository, not only the current directory, so .git stays writable
    # when claude is started in a subdirectory.
    workdir="$(${lib.getExe pkgs.git} rev-parse --show-toplevel 2>/dev/null || pwd)"

    # bwrap fails on missing mount targets, so only add paths that exist.
    extra=()
    hide_dir() { [ -d "$1" ] && extra+=(--tmpfs "$1"); }
    hide_file() { [ -e "$1" ] && extra+=(--ro-bind /dev/null "$1"); }
    ${lib.concatMapStrings (dir: "hide_dir \"$HOME/${dir}\"\n") hiddenHomeDirs}
    ${lib.concatMapStrings (file: "hide_file \"$HOME/${file}\"\n") hiddenHomeFiles}

    # Git runs hooks and config-defined commands (core.hooksPath, core.fsmonitor, core.sshCommand)
    # outside the sandbox the next time I use git in this repo, so both stay read-only. The hooks
    # directory is created first, otherwise it could be created inside the sandbox.
    if [ -d "$workdir/.git" ]; then
      mkdir -p "$workdir/.git/hooks"
      extra+=(--ro-bind "$workdir/.git/hooks" "$workdir/.git/hooks")
      [ -f "$workdir/.git/config" ] && extra+=(--ro-bind "$workdir/.git/config" "$workdir/.git/config")
    fi

    # Tool caches/state (go, cargo, podman, ansible) must be writable, the rest of $HOME stays
    # read-only. bin directories are deliberately not bound to prevent planting executables.
    # /tmp and $XDG_RUNTIME_DIR are private (host sockets like X11 or systemd --user would allow
    # escaping). Hidden and read-only paths come last so they override the binds above them.
    exec ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --ro-bind "$HOME" "$HOME" \
                                  --tmpfs /tmp \
                                  --bind "$HOME/.claude" "$HOME/.claude" \
                                  --bind "$HOME/.claude.json" "$HOME/.claude.json" \
                                  --bind-try "$HOME/.cache" "$HOME/.cache" \
                                  --bind-try "$HOME/go/pkg" "$HOME/go/pkg" \
                                  --bind-try "$HOME/.cargo/registry" "$HOME/.cargo/registry" \
                                  --bind-try "$HOME/.cargo/git" "$HOME/.cargo/git" \
                                  --bind-try "$HOME/.local/share/containers" "$HOME/.local/share/containers" \
                                  --bind-try "$HOME/.ansible" "$HOME/.ansible" \
                                  --bind "$workdir" "$workdir" \
                                  --tmpfs "$XDG_RUNTIME_DIR" \
                                  ${
                                    lib.concatMapStrings (
                                      dir: "--bind-try \"$XDG_RUNTIME_DIR/${dir}\" \"$XDG_RUNTIME_DIR/${dir}\" "
                                    ) runtimeDirs
                                  }\
                                  --proc /proc \
                                  --dev /dev \
                                  "''${extra[@]}" \
      ${lib.getExe pkgs.claude-code} "$@"
  '';

  skills = import ./command-prompts.nix;
in
{
  imports = [
    (import ./rules { configDir = ".claude"; })
  ];

  home = {
    packages = [
      claude-code-bwrapped
    ];
  };

  # Permissions and hooks live in /etc/claude-code/managed-settings.json (see managed-settings.nix),
  # only UI preferences stay here: ~/.claude is writable for the agent.
  home.file = {
    ".claude/settings.json".text = builtins.toJSON {
      editorMode = "vim";
      tui = "fullscreen";
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
