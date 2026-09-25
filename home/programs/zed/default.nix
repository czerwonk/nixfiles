{ pkgs, lib, ... }:

let
  zedProfile = pkgs.writeText "zed.profile" ''
    # basic filesystem protection
    read-only ~

    # hardening
    caps.drop all
    private-tmp

    # allow access to run for socket access
    writable-run-user

    # allow access to dev projects (blocks the rest of ~ automatically)
    whitelist ~/Projects
    read-write ~/Projects

    # allow access to config and caches
    whitelist ~/.config
    read-write ~/.config
    whitelist ~/.local
    read-write ~/.local
    whitelist ~/.cache
    read-write ~/.cache

    # allow access to claude config
    whitelist ~/.claude
    read-write ~/.claude
    whitelist ~/.claude.json
    read-write ~/.claude.json

    # allow home-manager / nix user profile bins
    whitelist ~/.nix-profile

    # allow ssh and gpg-agent
    whitelist ~/.gnupg
    read-write ~/.gnupg
    whitelist ~/.ssh/known_hosts
    whitelist ~/.ssh/config
    env SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh

    # allow podman
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

    # allow rust/cargo
    whitelist ~/.cargo
    read-write ~/.cargo
    whitelist ~/.rustup
    read-write ~/.rustup

    # allow go
    whitelist ~/go
    read-write ~/go
    whitelist ~/.cache/go-build
    read-write ~/.cache/go-build
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
