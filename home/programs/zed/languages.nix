{
  programs.zed-editor = {
    userSettings = {
      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
        };
      };
    };
  };
}
