{ extraHomeModules, ... }:

{
  imports = [
    ../../home
    ../../home/profiles/linux-utils
    ../../home/profiles/devops/lsp.nix
  ] ++ extraHomeModules;
}
