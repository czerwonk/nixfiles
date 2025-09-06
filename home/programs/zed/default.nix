{
  imports = [
    ./settings.nix
    ./keymaps.nix
    ./tasks.nix
  ];

  programs.zed-editor = {
    enable = true;
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
