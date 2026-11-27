{ pkgs, lib, ... }:

let
  # $HOME is an empty tmpfs inside the sandbox and only these paths are mounted into it, so
  # credentials of newly installed tools stay hidden without maintaining a deny list. Writes to
  # other paths in $HOME succeed but are discarded when the session ends.
  readOnlyHomePaths = [
    # other repositories, for lookups
    "Projects"
    # shell config for Claude's shell snapshot (~/.profile stays hidden: not needed here)
    ".zshrc"
    ".zshenv"
    # git identity, ssh signing and push (keys live on YubiKeys, reached via the agent socket)
    ".config/git"
    ".ssh/config"
    ".ssh/known_hosts"
    ".gnupg/gpg.conf"
    ".gnupg/gpg-agent.conf"
    ".gnupg/pubring.kbx"
    ".gnupg/trustdb.gpg"
    # tool config
    ".config/nix"
    ".config/containers"
    ".config/go"
    ".rustup"
    # openspec profile/delivery, so `openspec init/update` inside the sandbox matches the one outside
    ".config/openspec"
    # read-only, so no executables can be planted
    ".cargo/bin"
    "go/bin"
    # registry logins stay usable on purpose
    ".docker/config.json"
    ".npmrc"
    ".cargo/credentials.toml"
  ];
  # Tool caches/state (go, cargo, ansible). ~/.claude and ~/.claude.json are bound
  # separately because the sandbox must not start without them.
  writableHomePaths = [
    ".cache"
    "go/pkg"
    ".cargo/registry"
    ".cargo/git"
    ".ansible"
  ];
  # Only these runtime dirs are reachable: the gpg/ssh agent for git push/signing and podman state.
  # Everything else in $XDG_RUNTIME_DIR would allow running commands outside the sandbox
  # (systemd --user, tmux, nvim) or reading secrets (session bus, keyring). The podman API socket
  # is bound separately (see claude-code-bwrapped).
  runtimeDirs = [
    "gnupg"
    "containers"
    "libpod"
  ];

  claude-code-bwrapped = pkgs.writeShellScriptBin "claude" ''
    # Bind the whole repository, not only the current directory, so .git stays writable
    # when claude is started in a subdirectory.
    workdir="$(${lib.getExe pkgs.git} rev-parse --show-toplevel 2>/dev/null || pwd)"

    extra=()

    # Git runs hooks and config-defined commands (core.hooksPath, core.fsmonitor, core.sshCommand)
    # outside the sandbox the next time I use git in this repo, so both stay read-only. The hooks
    # directory is created first, otherwise it could be created inside the sandbox.
    if [ -d "$workdir/.git" ]; then
      mkdir -p "$workdir/.git/hooks"
      extra+=(--ro-bind "$workdir/.git/hooks" "$workdir/.git/hooks")
      [ -f "$workdir/.git/config" ] && extra+=(--ro-bind "$workdir/.git/config" "$workdir/.git/config")
    fi

    # Rootless podman can't run inside bwrap (no /sys/fs/cgroup, single-ID user namespace,
    # NoNewPrivs blocks newuidmap), so podman runs in remote mode against the host's rootless
    # service. Only the API socket is bound; every podman call is reviewed (managed-settings.nix).
    podman_socket="$XDG_RUNTIME_DIR/podman/podman.sock"
    if [ -S "$podman_socket" ]; then
      extra+=(--bind "$podman_socket" "$podman_socket" --setenv CONTAINER_HOST "unix://$podman_socket")
    fi

    # The Wayland socket enables pasting images (Claude Code reads them via wl-paste). Accepted
    # trade-off: clients can read the clipboard (data-control) and open windows, but unlike X11
    # they can't log keys or inject input into other windows.
    if [ -n "''${WAYLAND_DISPLAY:-}" ] && [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; then
      extra+=(--ro-bind "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY")
    fi

    # /tmp and $XDG_RUNTIME_DIR are private (host sockets like X11 or systemd --user would allow
    # escaping). Order matters: later binds override earlier ones, so the workdir (possibly inside
    # ~/Projects) comes after the read-only paths and the git read-only paths come last.
    exec ${lib.getExe pkgs.bubblewrap} --ro-bind /usr /usr \
                                  --ro-bind /nix /nix \
                                  --ro-bind /bin /bin \
                                  --ro-bind /etc /etc \
                                  --ro-bind /run/current-system/sw/bin /run/current-system/sw/bin \
                                  --tmpfs "$HOME" \
                                  --tmpfs /tmp \
                                  ${
                                    lib.concatMapStrings (path: "--ro-bind-try \"$HOME/${path}\" \"$HOME/${path}\" ") readOnlyHomePaths
                                  }\
                                  --bind "$HOME/.claude" "$HOME/.claude" \
                                  --bind "$HOME/.claude.json" "$HOME/.claude.json" \
                                  ${
                                    lib.concatMapStrings (path: "--bind-try \"$HOME/${path}\" \"$HOME/${path}\" ") writableHomePaths
                                  }\
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

  programs.worktrunk.claudeCodeIntegration.enable = true;
}
