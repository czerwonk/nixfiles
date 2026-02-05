{ lib, ... }:

{
  imports = [
    ./settings.nix
    ./keymaps.nix
    ./tasks.nix
  ];

  programs.zed-editor = {
    enable = lib.mkDefault false;
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
