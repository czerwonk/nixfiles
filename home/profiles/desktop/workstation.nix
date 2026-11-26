{
  imports = [
    ../agentic-coding
  ];

  programs.atuin.enable = true;
  programs.fzf.enableZshIntegration = false;
  programs.television.enable = true;
  programs.neovim.withCoding = true;
  programs.zed-editor.withCoding = true;
}
