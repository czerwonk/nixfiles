{
  imports = [
    ../agentic-coding
  ];

  programs.atuin.enable = true;
  programs.fzf.historyWidget.command = "";
  programs.neovim.withCoding = true;
  programs.zed-editor.withCoding = true;
}
