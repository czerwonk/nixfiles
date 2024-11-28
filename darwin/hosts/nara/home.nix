{ extraHomeModules, ... }:

{
  imports = [
    ../../../home/osx
    ../../../home/profiles/devops
  ] ++ extraHomeModules;
}
