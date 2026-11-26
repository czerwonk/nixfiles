{ pkgs, lib, ... }:

let
  zedProfile = pkgs.writeText "zed.profile" ''
    # basic filesystem protection
    read-only ~

    # hardening
    caps.drop all
    private-tmp

    # writable-run-user is needed for the gnupg socket directory. Only the listed sockets are
    # visible: the systemd --user socket would allow running commands outside the sandbox.
    # Same entries as firejail's whitelist-runuser-common.inc (/etc/firejail doesn't exist here).
    # Not $XDG_RUNTIME_DIR/doc: the document portal's FUSE mount denies root, firejail's setup fails.
    writable-run-user
    whitelist ''${RUNUSER}/bus
    whitelist ''${RUNUSER}/dconf
    whitelist ''${RUNUSER}/pulse/native
    whitelist ''${RUNUSER}/pipewire-*
    whitelist ''${RUNUSER}/wayland-*
    whitelist ''${RUNUSER}/gnupg
    whitelist ''${RUNUSER}/podman
    whitelist ''${RUNUSER}/keyring

    # The session bus allows starting commands outside the sandbox (systemd-run --user), so only
    # portals (file dialogs), dconf (GTK settings), notifications and the keyring are reachable.
    # Keyring access is a deliberate trade-off: Zed keeps its tokens there.
    dbus-user filter
    dbus-user.talk org.freedesktop.portal.*
    dbus-user.talk ca.desrt.dconf
    dbus-user.talk org.freedesktop.Notifications
    dbus-user.talk org.freedesktop.secrets

    # allow access to dev projects (blocks the rest of ~ automatically)
    whitelist ~/Projects
    read-write ~/Projects

    # Only what Zed needs from ~/.config and ~/.local: whitelisting the whole directories exposed
    # every installed app and allowed planting autostart entries, systemd user units and .desktop
    # files that run outside the sandbox.
    whitelist ~/.config/zed
    read-write ~/.config/zed
    whitelist ~/.local/share/zed
    read-write ~/.local/share/zed
    whitelist ~/.cache
    read-write ~/.cache

    # tool config for the terminal
    whitelist ~/.config/git
    whitelist ~/.config/nix
    whitelist ~/.config/containers
    whitelist ~/.config/go
    whitelist ~/.config/atuin
    whitelist ~/.config/oh-my-posh

    # nvim as git editor: plugins stay read-only, otherwise code could be planted that runs in nvim
    # outside the sandbox
    whitelist ~/.config/nvim
    whitelist ~/.local/share/nvim
    whitelist ~/.local/state/nvim
    read-write ~/.local/state/nvim
    whitelist ~/.local/share/zoxide
    read-write ~/.local/share/zoxide

    # fonts, theme and file associations
    whitelist ~/.config/fontconfig
    whitelist ~/.config/gtk-3.0
    whitelist ~/.config/gtk-4.0
    whitelist ~/.config/dconf
    whitelist ~/.config/cosmic
    whitelist ~/.config/mimeapps.list
    whitelist ~/.local/share/fonts
    whitelist ~/.local/share/icons
    whitelist ~/.local/share/themes

    # allow access to claude config
    whitelist ~/.claude
    read-write ~/.claude
    whitelist ~/.claude.json
    read-write ~/.claude.json

    # allow home-manager / nix user profile bins
    whitelist ~/.nix-profile

    # allow ssh and gpg-agent; read-only because the agent outside the sandbox loads its config
    # (e.g. pinentry-program) from here
    whitelist ~/.gnupg
    whitelist ~/.ssh/known_hosts
    whitelist ~/.ssh/config
    env SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh

    # allow podman
    whitelist ~/.local/share/containers
    read-write ~/.local/share/containers
    whitelist ~/.docker
    env CONTAINER_HOST=unix:///run/user/1000/podman/podman.sock

    # allow shell and history
    whitelist ~/.zshrc
    whitelist ~/.zshenv
    whitelist ~/.zprofile
    whitelist ~/.bashrc
    whitelist ~/.profile
    whitelist ~/.zsh_history
    read-write ~/.zsh_history
    whitelist ~/.atuin
    read-write ~/.atuin
    whitelist ~/.local/share/atuin
    read-write ~/.local/share/atuin
    # atuin's sync key
    blacklist ~/.local/share/atuin/key

    # allow rust/cargo; bin directories stay read-only (after read-write, order matters), so no
    # executables can be planted in PATH
    whitelist ~/.cargo
    read-write ~/.cargo
    read-only ~/.cargo/bin
    whitelist ~/.rustup
    read-write ~/.rustup

    # allow go
    whitelist ~/go
    read-write ~/go
    read-only ~/go/bin
    whitelist ~/.cache/go-build
    read-write ~/.cache/go-build

    # allow dotnet
    whitelist ~/.dotnet
    read-write ~/.dotnet

    # allow npm
    whitelist ~/.npm
    read-write ~/.npm
  '';
  zed-firejailed = pkgs.symlinkJoin {
    name = "zed-firejailed-${pkgs.zed-editor.version}";
    paths = [ pkgs.zed-editor ];

    postBuild = ''
      rm $out/bin/zeditor

      cat << 'EOF' > $out/bin/zeditor
      #!/bin/sh
      exec /run/wrappers/bin/firejail --profile=${zedProfile} --env=WAYLAND_DISPLAY="$WAYLAND_DISPLAY" ${pkgs.zed-editor}/bin/zeditor "$@"
      EOF

      chmod +x $out/bin/zeditor

      ln -s $out/bin/zeditor $out/bin/zed
    '';
  };

in
{
  imports = [
    ./settings.nix
    ./keymaps.nix
  ];

  programs.zed-editor = {
    enable = lib.mkDefault false;
    package = zed-firejailed;
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
  };
}
