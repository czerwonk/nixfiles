# Security-relevant Claude Code settings. Deployed by the NixOS profile `agentic-coding` as
# /etc/claude-code/managed-settings.json: managed settings take precedence over user settings and
# /etc is read-only in both sandboxes (bwrap, firejail), so the agent can't weaken them.
{ pkgs, lib }:

let
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

  # Production credentials: "ask" instead of "deny", so reading stays possible when explicitly
  # requested. Read rules only cover the Read tool, not shell commands - agent-rules.md covers those.
  credentialFiles = [
    "**/.env"
    "**/.env.local"
    "**/.env.*.local"
    "**/.env.prod"
    "**/.env.production"
    "**/.env.staging"
    "**/secrets.yml"
    "**/secrets.yaml"
    "**/secrets.json"
    "**/secrets.toml"
    "**/secrets.env"
    "**/credentials.yml"
    "**/credentials.yaml"
    "**/credentials.json"
    "**/credentials.toml"
    "**/credentials.env"
    "**/appsettings.Production.json"
    "**/application-prod.*"
    "**/app/etc/env.php"
    "**/wp-config.php"
    "**/config/master.key"
    "**/*.tfvars"
    "**/*.tfstate"
    "**/*.tfstate.backup"
    "**/*.pem"
    "**/*.key"
    "**/*.p12"
    "**/*.pfx"
    "**/*.jks"
    "**/*.kdbx"
    "**/id_rsa*"
    "**/id_ed25519*"
    "**/.vault_pass*"
    "**/.vault-password*"
    "~/.ssh/**"
    "~/.gnupg/**"
    "~/.aws/**"
    "~/.kube/**"
    "~/.docker/config.json"
    "~/.netrc"
    "~/.git-credentials"
    "~/.pgpass"
    "~/.my.cnf"
    "~/.npmrc"
    "~/.cargo/credentials.toml"
    "~/.config/gh/**"
    "~/.config/gcloud/**"
    "~/.config/sops/**"
  ];
  secretCommands = [
    "kubectl get secret:*"
    "kubectl get secrets:*"
    "sops -d:*"
    "sops --decrypt:*"
    "sops decrypt:*"
    "ansible-vault view:*"
    "ansible-vault decrypt:*"
    "vault read:*"
    "vault kv get:*"
    "terraform output:*"
    "printenv:*"
    "env"
  ];
in
{
  permissions = {
    # Bypass mode would skip the podman review below.
    disableBypassPermissionsMode = "disable";
    # Every podman call is reviewed manually because the podman socket allows host mounts.
    ask = [
      "Bash(podman:*)"
      "Bash(podman-remote:*)"
    ]
    ++ map (pattern: "Read(${pattern})") credentialFiles
    ++ map (command: "Bash(${command})") secretCommands;
    # Rejected without a prompt:
    # - docker isn't installed (podman only)
    # - remote access is only done by me (git push runs ssh itself and isn't affected)
    # - curl on unix sockets could only reach the podman API and bypass the podman review
    deny = [
      "Bash(docker:*)"
      "Bash(docker-compose:*)"
      "Bash(ssh:*)"
      "Bash(scp:*)"
      "Bash(sftp:*)"
      "Bash(rsync:*)"
      "Bash(sshfs:*)"
      "Bash(mosh:*)"
      "Bash(curl --unix-socket:*)"
    ];
  };
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
}
